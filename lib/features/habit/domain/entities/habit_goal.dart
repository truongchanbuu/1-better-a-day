import 'package:equatable/equatable.dart';

import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/extensions/string_extension.dart';
import 'habit_frequency.dart';

class HabitGoal extends Equatable {
  final String goalId;
  final String habitId;
  final String goalDesc;
  final GoalType goalType;
  final double targetValue;
  final HabitFrequency goalFrequency;
  final GoalUnit goalUnit;

  const HabitGoal({
    required this.goalId,
    required this.habitId,
    required this.goalDesc,
    required this.goalType,
    required this.targetValue,
    required this.goalUnit,
    required this.goalFrequency,
  });

  factory HabitGoal.init() {
    return HabitGoal(
      goalId: '',
      habitId: '',
      goalDesc: '',
      goalType: GoalType.custom,
      targetValue: 0,
      goalUnit: GoalUnit.custom,
      goalFrequency: HabitFrequency.daily,
    );
  }

  HabitGoal copyWith({
    String? goalId,
    String? habitId,
    String? goalDesc,
    GoalType? goalType,
    double? currentValue,
    double? targetValue,
    GoalUnit? goalUnit,
    HabitFrequency? goalFrequency,
  }) {
    return HabitGoal(
      goalId: goalId ?? this.goalId,
      habitId: habitId ?? this.habitId,
      goalDesc: goalDesc ?? this.goalDesc,
      goalType: goalType ?? this.goalType,
      targetValue: targetValue ?? this.targetValue,
      goalUnit: goalUnit ?? this.goalUnit,
      goalFrequency: goalFrequency ?? this.goalFrequency,
    );
  }

  @override
  List<Object> get props {
    return [
      goalId,
      habitId,
      goalDesc,
      goalType,
      targetValue,
      goalUnit,
      goalFrequency,
    ];
  }

  String get target => '$targetValue ${goalUnit.name.toUpperCaseFirstLetter}';
}
