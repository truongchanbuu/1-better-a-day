import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'config/theme/app_theme.dart';
import 'core/constants/app_common.dart';
import 'features/auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'features/habit/presentations/blocs/validate_habit/validate_habit_bloc.dart';
import 'features/habit/presentations/pages/add_habit_page.dart';
import 'features/habit/presentations/pages/add_habit_with_ai_page.dart';
import 'features/settings/presentations/bloc/settings_cubit.dart';
import 'features/shared/presentations/blocs/internet/internet_bloc.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';

// TODO: PACKAGES:
// - TIME_PLANNER FOR TIME SCHEDULE
// FREQUENCY OF HABIT
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt.get<AuthBloc>()..add(AuthUserSubscriptionRequest()),
        ),
        BlocProvider(create: (context) => getIt.get<SettingsCubit>())
      ],
      child: const AppContainer(),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
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
      // home: const AppView(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<ValidateHabitBloc>()),
          BlocProvider(create: (context) => getIt.get<InternetBloc>())
        ],
        child: const AddHabitWithAIPage(),
      ),
    );
  }
}
