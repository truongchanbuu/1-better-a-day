import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'config/route/app_route.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/app_common.dart';
import 'core/helpers/cached_client.dart';
import 'features/auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'features/habit/domain/repositories/habit_history_repository.dart';
import 'features/habit/domain/repositories/habit_repository.dart';
import 'features/habit/presentations/blocs/habit_history_crud/habit_history_crud_bloc.dart';
import 'features/habit/presentations/blocs/habit_progress/habit_progress_bloc.dart';
import 'features/habit/presentations/helpers/habit_progress_observer.dart';
import 'features/habit/presentations/helpers/habit_streak_observer.dart';
import 'features/rewards/presentations/blocs/challenge_crud/challenge_crud_bloc.dart';
import 'features/settings/presentations/bloc/settings_cubit/settings_cubit.dart';
import 'features/shared/presentations/blocs/internet/internet_bloc.dart';
import 'features/shared/presentations/pages/app_view.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';
import 'services/reminder_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterForegroundTask.initCommunicationPort();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late HabitStreakObserver _streakObserver;
  late HabitProgressObserver _habitProgressObserver;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final habitProgressBloc = getIt.get<HabitProgressBloc>();
    _habitProgressObserver = HabitProgressObserver(habitProgressBloc);
    getIt.registerSingleton<HabitProgressObserver>(_habitProgressObserver);

    final habitHistoryCrudBloc = getIt.get<HabitHistoryCrudBloc>();
    _streakObserver = HabitStreakObserver(
      habitRepository: getIt.get<HabitRepository>(),
      habitHistoryRepository: getIt.get<HabitHistoryRepository>(),
      settingsCubit: getIt.get<SettingsCubit>(),
      habitHistoryCrudBloc: habitHistoryCrudBloc,
      cachedClient: getIt.get<CacheClient>(),
      reminderService: getIt.get<ReminderService>(),
    );
    getIt.registerSingleton<HabitStreakObserver>(_streakObserver);
  }

  @override
  void dispose() {
    _streakObserver.dispose();
    _habitProgressObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt.get<AuthBloc>()..add(AuthUserSubscriptionRequest()),
        ),
        BlocProvider(create: (_) => getIt.get<SettingsCubit>()),
        BlocProvider(create: (_) => getIt.get<InternetBloc>()),
        BlocProvider(create: (_) => getIt.get<ChallengeCrudBloc>()),
        BlocProvider(create: (_) => getIt.get<HabitProgressBloc>()),
      ],
      child: const AppContainer(),
    );
  }
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer, routeObserver],
      navigatorKey: AppRoute.navigatorKey,
      builder: FlutterSmartDialog.init(),
      title: AppCommons.appName,
      themeMode: context.select((SettingsCubit settings) =>
          settings.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      locale:
          context.select((SettingsCubit settings) => settings.currentLocale),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AppView(),
    );
  }
}
