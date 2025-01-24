import 'package:equatable/equatable.dart';

import '../../../../../core/enums/habit/goal_unit.dart';
import 'achievement_requirement.dart';

class AccumulationRequirement extends Equatable
    implements AchievementRequirement {
  final num target;
  final num current;
  @override
  final GoalUnit baseUnit;
  @override
  final Set<GoalUnit> acceptableUnits;

  AccumulationRequirement({
    required this.target,
    required this.baseUnit,
    required this.acceptableUnits,
    this.current = 0,
  })  : assert(acceptableUnits.isNotEmpty, 'Units cannot be empty'),
        assert(
          acceptableUnits.contains(baseUnit),
          'Base unit must be included in the acceptable units',
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'current': current,
      'acceptableUnits': acceptableUnits.map((e) => e.name).toList(),
      'baseUnit': baseUnit.name,
    };
  }

  factory AccumulationRequirement.fromJson(Map<String, dynamic> json) {
    return AccumulationRequirement(
      target: json['target'],
      current: json['current'],
      acceptableUnits: json['acceptableUnits'] is Iterable
          ? Set<GoalUnit>.from(
              json['acceptableUnits']
                  .map((unitName) => GoalUnit.fromString(unitName)),
            )
          : {},
      baseUnit: GoalUnit.fromString(json['baseUnit']),
    );
  }

  @override
  AchievementRequirement checkAndUpdate(value) {
    if (value is! num) throw FormatException('Invalid num');

    return AccumulationRequirement(
      target: target,
      current: current + value,
      acceptableUnits: acceptableUnits,
      baseUnit: baseUnit,
    );
  }

  @override
  bool get isCompleted => current >= target;

  @override
  double get progress => (current / target).clamp(0.0, 1.0);

  @override
  bool get shouldReset => false;

  @override
  List<Object?> get props => [
        target,
        current,
        baseUnit,
        acceptableUnits,
      ];
}
