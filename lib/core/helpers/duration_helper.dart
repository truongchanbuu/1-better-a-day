import '../../features/habit/domain/entities/goal_unit.dart';

class DurationHelper {
  static Duration? getDurationFromGoalUnit(double value, GoalUnit? unit) {
    switch (unit) {
      case GoalUnit.second:
        return Duration(seconds: value.toInt());
      case GoalUnit.minute:
        return Duration(minutes: value.toInt());
      case GoalUnit.hour:
        return Duration(hours: value.toInt());
      case GoalUnit.day:
        return Duration(days: value.toInt());
      default:
        return null;
    }
  }
}
