import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get toShortString {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

  static TimeOfDay? tryParse(String? time) {
    if (time == null) return null;
    final format = RegExp(r'^(?:[01]?\d|2[0-3]):[0-5]\d$');
    if (!format.hasMatch(time)) {
      return null;
    }

    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
