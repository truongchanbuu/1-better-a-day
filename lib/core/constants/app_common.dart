import 'package:cloud_firestore/cloud_firestore.dart';

import '../../injection_container.dart';

class AppCommons {
  static const String appName = 'One Better A Day';
  static const String shortAppName = '1BAD';

  static const int searchDebounceTime = 200;

  static const Duration pageTransitionDuration = Duration(milliseconds: 500);
  static const Duration buttonBounceDuration = Duration(milliseconds: 300);
  static const Duration chartDuration = Duration(milliseconds: 400);
  static const Duration alertShowDuration = Duration(seconds: 5);

  static final firebaseStore = getIt.get<FirebaseFirestore>();
}
