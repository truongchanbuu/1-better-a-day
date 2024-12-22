import '../../helpers/enum_helper.dart';

enum HabitFrequency {
  daily,
  weekly,
  monthly,
  custom;

  static HabitFrequency fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? custom;

  int? get inNum => switch (this) {
        HabitFrequency.daily => 1,
        HabitFrequency.weekly => 7,
        HabitFrequency.monthly => 30,
        HabitFrequency.custom => null,
      };

  static HabitFrequency fromNum(int? num) {
    if (num == 1) {
      return daily;
    } else if (num == 7) {
      return weekly;
    } else if (num == 30) {
      return monthly;
    }

    return custom;
  }
}
