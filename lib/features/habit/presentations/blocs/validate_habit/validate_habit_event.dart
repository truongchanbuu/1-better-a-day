part of 'validate_habit_bloc.dart';

sealed class ValidateHabitEvent extends Equatable {
  const ValidateHabitEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeHabitName extends ValidateHabitEvent {
  final String habitName;
  const ChangeHabitName(this.habitName);

  @override
  List<Object?> get props => [habitName];
}

final class ChangeHabitDesc extends ValidateHabitEvent {
  final String desc;
  const ChangeHabitDesc(this.desc);

  @override
  List<Object?> get props => [desc];
}

final class ChangeHabitGoal extends ValidateHabitEvent {
  final String goalDesc;
  const ChangeHabitGoal(this.goalDesc);

  @override
  List<Object?> get props => [goalDesc];
}

final class ChangeGoalType extends ValidateHabitEvent {
  final String goalType;
  const ChangeGoalType(this.goalType);

  @override
  List<Object?> get props => [goalType];
}

final class ChangeGoalTargetValue extends ValidateHabitEvent {
  final double targetValue;
  const ChangeGoalTargetValue(this.targetValue);

  @override
  List<Object?> get props => [targetValue];
}

final class ChangeGoalTargetUnit extends ValidateHabitEvent {
  final String unit;
  const ChangeGoalTargetUnit(this.unit);

  @override
  List<Object?> get props => [unit];
}

final class ChangeHabitCategory extends ValidateHabitEvent {
  final String category;
  const ChangeHabitCategory(this.category);

  @override
  List<Object?> get props => [category];
}

final class ChangeRemindTime extends ValidateHabitEvent {
  final String reminderTime;
  const ChangeRemindTime(this.reminderTime);

  @override
  List<Object?> get props => [reminderTime];
}

final class ChangeFrequency extends ValidateHabitEvent {
  final int frequency;
  const ChangeFrequency(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

final class ChangeStartDate extends ValidateHabitEvent {
  final DateTime startDate;
  const ChangeStartDate(this.startDate);

  @override
  List<Object?> get props => [startDate];
}

final class ChangeEndDate extends ValidateHabitEvent {
  final DateTime endDate;
  const ChangeEndDate(this.endDate);

  @override
  List<Object?> get props => [endDate];
}

final class ValidateHabit extends ValidateHabitEvent {}

final class AnalyzeHabitGoal extends ValidateHabitEvent {
  final String goal;
  const AnalyzeHabitGoal(this.goal);

  @override
  List<Object?> get props => [goal];
}