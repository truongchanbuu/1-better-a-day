import 'package:equatable/equatable.dart';

import '../../../../../core/enums/habit/goal_unit.dart';
import 'achievement_requirement.dart';

class StreakRequirement extends Equatable implements AchievementRequirement {
  final int requiredDays;
  final int currentStreak;
  final DateTime? lastUpdated;
  @override
  final Set<GoalUnit> acceptableUnits;
  @override
  final GoalUnit baseUnit;

  StreakRequirement({
    required this.requiredDays,
    this.currentStreak = 0,
    required this.acceptableUnits,
    required this.baseUnit,
    this.lastUpdated,
  })  : assert(acceptableUnits.isNotEmpty, 'Units cannot be empty'),
        assert(
          acceptableUnits.contains(baseUnit),
          'Base unit must be included in the acceptable acceptableUnits',
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'requiredDays': requiredDays,
      'currentStreak': currentStreak,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'acceptableUnits': acceptableUnits.map((e) => e.name).toList(),
      'baseUnit': baseUnit.name,
    };
  }

  factory StreakRequirement.fromJson(Map<String, dynamic> json) {
    return StreakRequirement(
      requiredDays: json['requiredDays'],
      currentStreak: json['currentStreak'],
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
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
  bool get isCompleted => currentStreak >= requiredDays;

  @override
  double get progress => currentStreak / requiredDays.toDouble();

  @override
  bool get shouldReset {
    if (lastUpdated == null) return false;
    return DateTime.now().difference(lastUpdated!).inDays > 1;
  }

  @override
  AchievementRequirement checkAndUpdate(dynamic value) {
    final bool completed = value as bool;
    final now = DateTime.now();

    if (shouldReset) {
      return StreakRequirement(
        requiredDays: requiredDays,
        currentStreak: completed ? 1 : 0,
        lastUpdated: now,
        acceptableUnits: acceptableUnits,
        baseUnit: baseUnit,
      );
    }
    return StreakRequirement(
      requiredDays: requiredDays,
      currentStreak: completed ? currentStreak + 1 : 0,
      lastUpdated: now,
      acceptableUnits: acceptableUnits,
      baseUnit: baseUnit,
    );
  }

  @override
  List<Object?> get props => [
        requiredDays,
        currentStreak,
        lastUpdated,
        baseUnit,
        acceptableUnits,
      ];
}
