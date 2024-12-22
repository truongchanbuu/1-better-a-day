part of 'validate_habit_bloc.dart';

sealed class ValidateHabitState extends Equatable {
  final String habitName;
  final String habitDesc;
  final HabitGoal habitGoal;
  final String reminderTime;
  final String habitCategory;
  final DateTime startDate;
  final DateTime endDate;
  final String habitFrequency;
  final String? errorMessage;

  ValidateHabitState({
    this.habitName = '',
    this.habitDesc = '',
    this.habitCategory = '',
    this.habitFrequency = '',
    this.reminderTime = '',
    HabitGoal? habitGoal,
    DateTime? startDate,
    DateTime? endDate,
    this.errorMessage,
  })  : habitGoal = habitGoal ?? HabitGoal.init(),
        startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now().add(const Duration(days: 21));

  @override
  List<Object?> get props => [
        habitName,
        habitDesc,
        habitGoal,
        habitCategory,
        startDate,
        endDate,
        habitFrequency,
        errorMessage,
      ];
}

final class ValidateHabitInitial extends ValidateHabitState {}

final class HabitNameChanged extends ValidateHabitState {
  HabitNameChanged({
    required ValidateHabitState current,
    required super.habitName,
  }) : super(
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitDescChanged extends ValidateHabitState {
  HabitDescChanged({
    required ValidateHabitState current,
    required super.habitDesc,
  }) : super(
          habitName: current.habitName,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalDescChanged extends ValidateHabitState {
  HabitGoalDescChanged({
    required ValidateHabitState current,
    required String habitGoalDesc,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalDesc: habitGoalDesc),
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalTypeChanged extends ValidateHabitState {
  HabitGoalTypeChanged({
    required ValidateHabitState current,
    required String goalType,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalType: goalType),
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalTargetValueChanged extends ValidateHabitState {
  HabitGoalTargetValueChanged({
    required ValidateHabitState current,
    required double targetValue,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(targetValue: targetValue),
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalUnitChanged extends ValidateHabitState {
  HabitGoalUnitChanged({
    required ValidateHabitState current,
    required String unit,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalUnit: unit),
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitCategoryChanged extends ValidateHabitState {
  HabitCategoryChanged({
    required ValidateHabitState current,
    required super.habitCategory,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitTimeReminderChanged extends ValidateHabitState {
  HabitTimeReminderChanged({
    required ValidateHabitState current,
    required super.reminderTime,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitFrequencyChanged extends ValidateHabitState {
  HabitFrequencyChanged({
    required ValidateHabitState current,
    required int frequency,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalFrequency: frequency),
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: frequency.toString(),
          errorMessage: current.errorMessage,
        );
}

final class HabitStartDateChanged extends ValidateHabitState {
  HabitStartDateChanged({
    required ValidateHabitState current,
    required DateTime startDate,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class HabitEndDateChanged extends ValidateHabitState {
  HabitEndDateChanged({
    required ValidateHabitState current,
    required DateTime endDate,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}

final class ValidateFailed extends ValidateHabitState {
  ValidateFailed({
    required ValidateHabitState current,
    required String errorMessage,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: errorMessage,
        );
}

final class ValidateSucceed extends ValidateHabitState {
  ValidateSucceed({required ValidateHabitState current})
      : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTime: current.reminderTime,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitFrequency: current.habitFrequency,
          errorMessage: current.errorMessage,
        );
}
