import 'package:collection/collection.dart';

class EnumHelper<T> {
  static T? fromString<T>(List<T> values, String? str) {
    return values.firstWhereOrNull(
      (t) => t.toString().split('.').last == str?.toLowerCase().trim(),
    );
  }

  static T? getMostFrequentEnumValue<T, E>(
      List<E> items, T Function(E entity) selector) {
    final Map<T, int> frequencyMap = {};

    if (items.isEmpty) return null;

    for (var item in items) {
      final key = selector(item);
      frequencyMap[key] = (frequencyMap[key] ?? 0) + 1;
    }

    return frequencyMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}
