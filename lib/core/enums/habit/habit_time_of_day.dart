import '../../../generated/l10n.dart';

enum HabitTimeOfDay {
  morning,
  afternoon,
  evening,
  night,
  anytime;

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
}
