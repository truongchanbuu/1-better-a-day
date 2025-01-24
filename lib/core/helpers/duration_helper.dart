import '../enums/habit/goal_unit.dart';

class DurationHelper {
  static Duration? getDurationFromGoalUnit(num value, GoalUnit? unit) {
    switch (unit) {
      case GoalUnit.second:
        return Duration(
            seconds: value.floor(),
            milliseconds: ((value - value.floor()) * 1000).round());
      case GoalUnit.minute:
        return Duration(
            minutes: value.floor(),
            seconds: ((value - value.floor()) * 60).round());
      case GoalUnit.hour:
        return Duration(
            hours: value.floor(),
            minutes: ((value - value.floor()) * 60).round());
      default:
        return null;
    }
  }
}
