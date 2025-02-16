import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/log/app_logger.dart';
import 'core/helpers/cached_client.dart';
import 'features/auth/data/models/user.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/presentations/bloc/login/login_cubit.dart';
import 'features/auth/presentations/bloc/signup/signup_cubit.dart';
import 'features/habit/data/models/habit_history_model.dart';
import 'features/habit/data/models/habit_model.dart';
import 'features/habit/data/repositories/habit_ai_repo_impl.dart';
import 'features/habit/data/repositories/habit_history_repo_impl.dart';
import 'features/habit/data/repositories/habit_repo_impl.dart';
import 'features/habit/domain/entities/habit_history.dart';
import 'features/habit/domain/repositories/habit_ai_repository.dart';
import 'features/habit/domain/repositories/habit_history_repository.dart';
import 'features/habit/domain/repositories/habit_repository.dart';
import 'features/habit/presentations/blocs/ai_habit_generate/ai_habit_generate_bloc.dart';
import 'features/habit/presentations/blocs/crud/habit_crud_bloc.dart';
import 'features/habit/presentations/blocs/distance_track/distance_track_cubit.dart';
import 'features/habit/presentations/blocs/habit_history_crud/habit_history_crud_bloc.dart';
import 'features/habit/presentations/blocs/habit_progress/habit_progress_bloc.dart';
import 'features/habit/presentations/blocs/habit_time_tracker/habit_time_tracker_bloc.dart';
import 'features/habit/presentations/blocs/review_habit_action/review_habit_action_bloc.dart';
import 'features/habit/presentations/blocs/share_habit/share_habit_bloc.dart';
import 'features/habit/presentations/blocs/statistic_crud/statistic_crud_bloc.dart';
import 'features/habit/presentations/blocs/validate_habit/validate_habit_bloc.dart';
import 'features/notification/data/models/reminder_model.dart';
import 'features/notification/data/repositories/reminder_repo_impl.dart';
import 'features/notification/domain/entities/reminder_entity.dart';
import 'features/notification/domain/repositories/reminder_repository.dart';
import 'features/notification/presentations/blocs/reminder/reminder_bloc.dart';
import 'features/rewards/data/models/achievement_model.dart';
import 'features/rewards/data/repositories/achievement_repository_impl.dart';
import 'features/rewards/domain/entities/achievements/achievement_entity.dart';
import 'features/rewards/domain/entities/achievements/pre_defined/pre_defined_achievements.dart';
import 'features/rewards/domain/repositories/achievement_repository.dart';
import 'features/rewards/presentations/blocs/challenge_crud/challenge_crud_bloc.dart';
import 'features/rewards/presentations/blocs/collection_crud/collection_crud_bloc.dart';

import 'features/settings/presentations/bloc/settings_cubit.dart';
import 'features/shared/presentations/blocs/internet/internet_bloc.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/presentations/bloc/update_info_cubit.dart';
import 'services/api_service.dart';
import 'services/hive_crud_service.dart';
import 'services/impl/api_service_impl.dart';
import 'services/impl/hive_crud_implement.dart';
import 'services/reminder_service.dart';

final getIt = GetIt.I;

Future<void> initializeDependencies() async {
  await Hive.initFlutter();

  final habitBox = await Hive.openBox<Map<dynamic, dynamic>>('habits');
  getIt.registerSingleton<Box<Map<dynamic, dynamic>>>(habitBox,
      instanceName: 'habitBox');
  getIt.registerFactory<HiveCRUDInterface<HabitModel>>(
    () => HiveCRUDImplementation<HabitModel>(
      getIt.get<Box<Map<dynamic, dynamic>>>(instanceName: 'habitBox'),
      () => HabitModel.init(),
    ),
  );
  final habitHistoryBox =
      await Hive.openBox<Map<dynamic, dynamic>>('habitHistories');
  getIt.registerSingleton<Box<Map<dynamic, dynamic>>>(habitHistoryBox,
      instanceName: 'habitHistoryBox');
  getIt.registerFactory<HiveCRUDInterface<HabitHistoryModel>>(
    () => HiveCRUDImplementation<HabitHistoryModel>(
      getIt.get<Box<Map<dynamic, dynamic>>>(instanceName: 'habitHistoryBox'),
      () => HabitHistoryModel.fromEntity(HabitHistory.init()),
    ),
  );
  final challengeBox = await Hive.openBox<Map<dynamic, dynamic>>('challenges');
  getIt.registerSingleton<Box<Map<dynamic, dynamic>>>(challengeBox,
      instanceName: 'challengeBox');
  getIt.registerFactory<HiveCRUDInterface<AchievementModel>>(
    () => HiveCRUDImplementation(
      getIt.get<Box<Map<dynamic, dynamic>>>(instanceName: 'challengeBox'),
      () => AchievementModel.fromEntity(AchievementEntity.init()),
    ),
  );

  final reminderBox = await Hive.openBox<Map>('reminders');
  getIt.registerSingleton<Box<Map<dynamic, dynamic>>>(reminderBox,
      instanceName: 'reminderBox');
  getIt.registerFactory<HiveCRUDInterface<ReminderModel>>(
    () => HiveCRUDImplementation<ReminderModel>(
      getIt.get<Box<Map<dynamic, dynamic>>>(instanceName: 'reminderBox'),
      () => ReminderModel.fromEntity(ReminderEntity.init()),
    ),
  );
  // GEMINI
  await dotenv.load();
  getIt.registerSingleton(GenerativeModel(
    model: 'gemini-pro',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  ));

  // Logger
  getIt.registerSingleton(AppLogger());

  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Google
  getIt.registerFactory<GoogleSignIn>(() => GoogleSignIn.standard());

  // Storage
  getIt.registerSingleton<SharedPreferencesWithCache>(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    ),
  );
  getIt.registerSingleton<CacheClient>(CacheClient(getIt()));

  // API
  getIt.registerLazySingleton<ApiService<UserModel>>(
    () => ApiServiceImpl<UserModel>(
      collectionPath: 'users',
      firestore: getIt(),
      fromJson: UserModel.fromJson,
    ),
  );

  // Repository
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    firebaseAuth: getIt(),
    googleSignIn: getIt(),
    userRepository: getIt(),
    cache: getIt(),
  ));
  getIt.registerSingleton<HabitAIRepository>(HabitAIRepoImpl(getIt()));
  getIt.registerSingleton<HabitRepository>(HabitRepoImpl(getIt()));
  getIt
      .registerSingleton<HabitHistoryRepository>(HabitHistoryRepoImpl(getIt()));
  getIt.registerSingleton<ReminderRepository>(ReminderRepoImpl(getIt()));
  getIt.registerSingleton<AchievementRepository>(
      AchievementRepositoryImpl(getIt()));
  getIt.registerSingleton<ReminderService>(ReminderService());

  // Bloc
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt()));
  getIt.registerSingleton<InternetBloc>(InternetBloc());
  getIt.registerFactory<ValidateHabitBloc>(() => ValidateHabitBloc());
  getIt
      .registerFactory<AIHabitGenerateBloc>(() => AIHabitGenerateBloc(getIt()));
  getIt.registerFactory<HabitCrudBloc>(() => HabitCrudBloc(getIt()));
  getIt.registerFactory<HabitHistoryCrudBloc>(() => HabitHistoryCrudBloc(
        habitHistoryRepository: getIt(),
        habitRepository: getIt(),
        cacheClient: getIt(),
      ));
  getIt.registerCachedFactoryParam<HabitTimeTrackerBloc, int, void>(
      (target, _) => HabitTimeTrackerBloc(target));
  getIt.registerFactoryParam<ReviewHabitActionBloc, HabitHistory, void>(
      (history, _) => ReviewHabitActionBloc(history));
  getIt.registerFactory<ReminderBloc>(() => ReminderBloc(getIt()));
  getIt.registerFactory<ChallengeCrudBloc>(() => ChallengeCrudBloc(getIt()));
  getIt.registerFactory<CollectionCrudBloc>(() => CollectionCrudBloc(getIt()));
  getIt.registerFactory<StatisticCrudBloc>(
    () => StatisticCrudBloc(
      habitRepository: getIt(),
      achievementRepository: getIt(),
      habitHistoryRepository: getIt(),
    ),
  );
  getIt.registerSingleton<HabitProgressBloc>(
      HabitProgressBloc(getIt(), getIt()));
  getIt.registerFactory<ShareHabitBloc>(() => ShareHabitBloc());

  // Cubit
  getIt.registerSingleton<SettingsCubit>(SettingsCubit(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<UpdateInfoCubit>(() => UpdateInfoCubit(getIt()));
  getIt.registerFactoryParam<DistanceTrackCubit, double, void>(
    (targetDistance, _) => DistanceTrackCubit(targetDistance: targetDistance),
  );

  await getIt.get<AchievementRepository>().deleteAll();
  await getIt.get<ReminderService>().init();
  await PreDefinedAchievements.storeAllPredefinedAchievements();
}
