import '../../../../../core/enums/habit/goal_unit.dart';
import 'achievement_requirement.dart';

class AccumulationRequirement implements AchievementRequirement {
  final num target;
  final num current;
  final GoalUnit unit;

  AccumulationRequirement({
    required this.target,
    required this.unit,
    this.current = 0,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'current': current,
      'unit': unit.name,
    };
  }

  factory AccumulationRequirement.fromJson(Map<String, dynamic> json) {
    return AccumulationRequirement(
      target: json['target'],
      current: json['current'],
      unit: GoalUnit.fromString(json['unit']),
    );
  }
}
