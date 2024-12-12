extension NumExtension on num {
  String toStringAsFixedWithoutZero([int fractionDigits = 1]) {
    String result = toStringAsFixed(fractionDigits);
    if (result.endsWith('.0')) {
      return result.substring(0, result.length - 2);
    }
    return result;
  }
}
