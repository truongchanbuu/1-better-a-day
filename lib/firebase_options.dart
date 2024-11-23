// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDStNzwYMU_k7Ak_V1TNwIWAoSpqZP_yUg',
    appId: '1:668846190001:web:0fb0f39bde4a094178e190',
    messagingSenderId: '668846190001',
    projectId: 'better-a-day',
    authDomain: 'better-a-day.firebaseapp.com',
    storageBucket: 'better-a-day.firebasestorage.app',
    measurementId: 'G-ZSE2XNGP4N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwF_PthxzSNUiIlN-XpAIPJj4oMCKEALI',
    appId: '1:668846190001:android:3dee2297b65128f478e190',
    messagingSenderId: '668846190001',
    projectId: 'better-a-day',
    storageBucket: 'better-a-day.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF_Fs2X8pSdoyaCSaPC7S-saN-8rjZRRQ',
    appId: '1:668846190001:ios:4c82674b714394bf78e190',
    messagingSenderId: '668846190001',
    projectId: 'better-a-day',
    storageBucket: 'better-a-day.firebasestorage.app',
    iosBundleId: 'com.example.oneBetterADay',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF_Fs2X8pSdoyaCSaPC7S-saN-8rjZRRQ',
    appId: '1:668846190001:ios:4c82674b714394bf78e190',
    messagingSenderId: '668846190001',
    projectId: 'better-a-day',
    storageBucket: 'better-a-day.firebasestorage.app',
    iosBundleId: 'com.example.oneBetterADay',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDStNzwYMU_k7Ak_V1TNwIWAoSpqZP_yUg',
    appId: '1:668846190001:web:c9b65951cc39f16978e190',
    messagingSenderId: '668846190001',
    projectId: 'better-a-day',
    authDomain: 'better-a-day.firebaseapp.com',
    storageBucket: 'better-a-day.firebasestorage.app',
    measurementId: 'G-K9RW2WJYGK',
  );
}
