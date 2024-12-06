import 'package:equatable/equatable.dart';

import '../../../../core/extensions/string_extension.dart';

class HabitGoal extends Equatable {
  final String goalId;
  final String habitId;
  final String goalDesc;
  final String goalType;
  final double currentValue;
  final double targetValue;
  final String goalFrequency;
  final String goalUnit;

  const HabitGoal({
    required this.goalId,
    required this.habitId,
    required this.goalDesc,
    required this.goalType,
    this.currentValue = 0,
    required this.targetValue,
    required this.goalUnit,
    required this.goalFrequency,
  });

  HabitGoal copyWith({
    String? goalId,
    String? habitId,
    String? goalDesc,
    String? goalType,
    double? currentValue,
    double? targetValue,
    String? goalUnit,
    String? goalFrequency,
  }) {
    return HabitGoal(
      goalId: goalId ?? this.goalId,
      habitId: habitId ?? this.habitId,
      goalDesc: goalDesc ?? this.goalDesc,
      goalType: goalType ?? this.goalType,
      currentValue: currentValue ?? this.currentValue,
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
      currentValue,
      targetValue,
      goalUnit,
      goalFrequency,
    ];
  }

  String get target => '$targetValue ${goalUnit.toUpperCaseFirstLetter}';
}
