import 'package:collection/collection.dart';

class EnumHelper<T> {
  static T? fromString<T>(List<T> values, String? str) {
    return values.firstWhereOrNull(
      (t) => t.toString().split('.').last == str,
    );
  }
}
