import '../../../../../core/enums/habit/goal_unit.dart';
import '../achievement_requirement.dart';

class AccumulationRequirement implements AchievementRequirement {
  final num target;
  final num current;
  final GoalUnit unit;

  AccumulationRequirement({
    required this.target,
    required this.unit,
    this.current = 0,
  });
}
