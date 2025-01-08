part of 'validate_habit_bloc.dart';

sealed class ValidateHabitState extends Equatable {
  final String habitName;
  final String habitDesc;
  final HabitGoal habitGoal;
  final HabitIcon habitIcon;
  final Set<String> reminderTimes;
  final HabitCategory habitCategory;
  final DateTime startDate;
  final DateTime endDate;
  final String? errorMessage;

  ValidateHabitState({
    this.habitName = '',
    this.habitDesc = '',
    this.habitCategory = HabitCategory.custom,
    this.reminderTimes = const {},
    HabitIcon? habitIcon,
    HabitGoal? habitGoal,
    DateTime? startDate,
    DateTime? endDate,
    this.errorMessage,
  })  : habitGoal = habitGoal ?? HabitGoal.init(),
        startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now().add(const Duration(days: 21)),
        habitIcon =
            habitIcon ?? HabitIcon.fromKey(PredefinedHabitIconKey.custom);

  @override
  List<Object?> get props => [
        habitName,
        habitDesc,
        habitGoal,
        habitCategory,
        startDate,
        endDate,
        habitIcon,
        errorMessage,
        reminderTimes,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalTypeChanged extends ValidateHabitState {
  HabitGoalTypeChanged({
    required ValidateHabitState current,
    required GoalType goalType,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalType: goalType),
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
          errorMessage: current.errorMessage,
        );
}

final class HabitGoalUnitChanged extends ValidateHabitState {
  HabitGoalUnitChanged({
    required ValidateHabitState current,
    required GoalUnit unit,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalUnit: unit),
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
          errorMessage: current.errorMessage,
        );
}

final class HabitTimeReminderChanged extends ValidateHabitState {
  HabitTimeReminderChanged({
    required ValidateHabitState current,
    required super.reminderTimes,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
          errorMessage: current.errorMessage,
        );
}

final class HabitIconChanged extends ValidateHabitState {
  HabitIconChanged({
    required ValidateHabitState current,
    required super.habitIcon,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          errorMessage: current.errorMessage,
        );
}

final class HabitFrequencyChanged extends ValidateHabitState {
  HabitFrequencyChanged({
    required ValidateHabitState current,
    required HabitFrequency habitFrequency,
  }) : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal.copyWith(goalFrequency: habitFrequency),
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: startDate,
          endDate: current.endDate,
          habitIcon: current.habitIcon,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          habitIcon: current.habitIcon,
          endDate: endDate,
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
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          startDate: current.startDate,
          habitIcon: current.habitIcon,
          endDate: current.endDate,
          errorMessage: errorMessage,
        );
}

final class ValidateSucceed extends ValidateHabitState {
  ValidateSucceed({required ValidateHabitState current})
      : super(
          habitName: current.habitName,
          habitDesc: current.habitDesc,
          habitGoal: current.habitGoal,
          reminderTimes: current.reminderTimes,
          habitCategory: current.habitCategory,
          habitIcon: current.habitIcon,
          startDate: current.startDate,
          endDate: current.endDate,
          errorMessage: current.errorMessage,
        );
}

final class Validating extends ValidateHabitState {
  Validating(ValidateHabitState current)
      : super(
          reminderTimes: current.reminderTimes,
          endDate: current.endDate,
          startDate: current.startDate,
          errorMessage: current.errorMessage,
          habitGoal: current.habitGoal,
          habitDesc: current.habitDesc,
          habitCategory: current.habitCategory,
          habitName: current.habitName,
          habitIcon: current.habitIcon,
        );
}

final class HabitAdded extends ValidateHabitState {
  final HabitEntity habit;
  HabitAdded(this.habit);

  @override
  List<Object?> get props => [habit];
}

final class HabitAddFailed extends ValidateHabitState {
  HabitAddFailed({super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
