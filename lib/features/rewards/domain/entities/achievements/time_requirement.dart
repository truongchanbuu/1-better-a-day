import 'package:equatable/equatable.dart';

import '../../../../../core/enums/habit/goal_unit.dart';
import 'achievement_requirement.dart';

class TimeRequirement extends Equatable implements AchievementRequirement {
  final Duration targetTime;
  final Duration currentTime;
  @override
  final Set<GoalUnit> acceptableUnits;
  @override
  final GoalUnit baseUnit;

  TimeRequirement({
    required this.targetTime,
    this.currentTime = const Duration(),
    required this.acceptableUnits,
    required this.baseUnit,
  })  : assert(acceptableUnits.isNotEmpty, 'Units cannot be empty'),
        assert(
          acceptableUnits.contains(baseUnit),
          'Base unit must be included in the acceptable acceptableUnits',
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'targetTime': targetTime.inMilliseconds,
      'currentTime': currentTime.inMilliseconds,
      'acceptableUnits': acceptableUnits.map((e) => e.name).toList(),
      'baseUnit': baseUnit.name,
    };
  }

  factory TimeRequirement.fromJson(Map<String, dynamic> json) {
    return TimeRequirement(
      targetTime: Duration(milliseconds: json['targetTime']),
      currentTime: Duration(milliseconds: json['currentTime']),
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
  bool get isCompleted => currentTime >= targetTime;

  @override
  double get progress =>
      (currentTime.inSeconds / targetTime.inSeconds).clamp(0.0, 1.0);

  @override
  bool get shouldReset => false;

  @override
  AchievementRequirement checkAndUpdate(dynamic value) {
    if (value is! Duration) {
      throw FormatException('Invalid duration');
    }

    final Duration newTime = value;
    return TimeRequirement(
      targetTime: targetTime,
      currentTime: currentTime + newTime,
      acceptableUnits: acceptableUnits,
      baseUnit: baseUnit,
    );
  }

  @override
  List<Object?> get props => [
        targetTime,
        currentTime,
        baseUnit,
        acceptableUnits,
      ];
}
