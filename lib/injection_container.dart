import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/log/app_logger.dart';
import 'core/helpers/cached_client.dart';
import 'features/auth/data/models/user.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/presentations/bloc/login/login_cubit.dart';
import 'features/auth/presentations/bloc/signup/signup_cubit.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'services/api_service.dart';
import 'services/impl/api_service_impl.dart';

final getIt = GetIt.I;

Future<void> initializeDependencies() async {
  // Logger
  getIt.registerLazySingleton(() => AppLogger());

  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Google
  getIt.registerFactory<GoogleSignIn>(() => GoogleSignIn.standard());

  // SharedPreference
  getIt.registerSingleton<SharedPreferencesWithCache>(
    await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions()),
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
    appLogger: getIt(),
    cache: getIt(),
  ));

  // Bloc
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt()));

  // Cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
