import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum HabitTimeOfDay {
  morning,
  afternoon,
  evening,
  night,
  anytime;

  static TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String? getPartOfDay(TimeOfDay? time) {
    final int? hour = time?.hour;

    if (hour == null) return null;

    if (hour >= 5 && hour < 12) {
      return morning.name;
    } else if (hour >= 12 && hour < 17) {
      return afternoon.name;
    } else if (hour >= 17 && hour < 21) {
      return evening.name;
    } else {
      return night.name;
    }
  }

  String get greeting => switch (this) {
        HabitTimeOfDay.morning => S.current.morning_greeting,
        HabitTimeOfDay.afternoon => S.current.afternoon_greeting,
        HabitTimeOfDay.evening => S.current.evening_greeting,
        HabitTimeOfDay.night => S.current.night_greeting,
        HabitTimeOfDay.anytime => S.current.default_greeting,
      };

  static HabitTimeOfDay get periodOfTheDay {
    final int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return HabitTimeOfDay.morning;
    } else if (hour >= 12 && hour < 17) {
      return HabitTimeOfDay.afternoon;
    } else if (hour >= 17 && hour < 21) {
      return HabitTimeOfDay.evening;
    }

    return HabitTimeOfDay.night;
  }

  static HabitTimeOfDay fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? HabitTimeOfDay.anytime;
}
