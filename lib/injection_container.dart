import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'config/log/app_logger.dart';

class InjectionContainer {
  static final getIt = GetIt.I;

  static Future<void> initializeDependencies() async {
    // Logger
    getIt.registerLazySingleton(() => AppLogger());

    // Firebase
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  }
}
