import '../enums/habit/goal_unit.dart';

class DurationHelper {
  static Duration? getDurationFromGoalUnit(double value, GoalUnit? unit) {
    switch (unit) {
      case GoalUnit.second:
        return Duration(seconds: value.toInt());
      case GoalUnit.minutes:
        return Duration(minutes: value.toInt());
      case GoalUnit.hour:
        return Duration(hours: value.toInt());
      default:
        return null;
    }
  }
}
