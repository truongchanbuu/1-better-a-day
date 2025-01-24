import '../../../../../core/enums/habit/goal_unit.dart';

abstract interface class AchievementRequirement {
  Set<GoalUnit> get acceptableUnits;
  GoalUnit get baseUnit;

  Map<String, dynamic> toJson();

  bool get isCompleted;
  double get progress;
  bool get shouldReset;
  AchievementRequirement checkAndUpdate(dynamic newValue);
}
