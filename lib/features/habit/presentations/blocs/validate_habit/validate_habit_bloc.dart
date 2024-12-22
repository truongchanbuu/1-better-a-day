import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/entities/habit_goal.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'validate_habit_event.dart';
part 'validate_habit_state.dart';

class ValidateHabitBloc extends Bloc<ValidateHabitEvent, ValidateHabitState> {
  final HabitRepository habitRepository;

  static const Duration _debounceTime = Duration(milliseconds: 500);

  ValidateHabitBloc(this.habitRepository) : super(ValidateHabitInitial()) {
    on<ChangeHabitName>(
      _onHabitNameChanged,
      transformer: debounce(_debounceTime),
    );
    on<ChangeHabitDesc>(
      _onHabitDescChanged,
      transformer: debounce(_debounceTime),
    );
    on<ChangeHabitGoal>(
      _onChangeHabitGoal,
      transformer: debounce(_debounceTime),
    );
    on<ChangeGoalType>(
      _onChangeGoalType,
      transformer: debounce(_debounceTime),
    );
    on<ChangeGoalTargetValue>(
      _onChangeGoalTargetValue,
      transformer: debounce(_debounceTime),
    );
    on<ChangeGoalTargetUnit>(
      _onHabitUnitChange,
      transformer: debounce(_debounceTime),
    );
    on<ChangeHabitCategory>(_onHabitCategory);
    on<ChangeFrequency>(
      _onHabitFrequencyChanged,
      transformer: debounce(_debounceTime),
    );
    on<ChangeRemindTime>(_onHabitReminderChanged);
    on<ChangeStartDate>(_onStartDateChanged);
    on<ChangeEndDate>(_onEndDateChanged);
    on<ValidateHabit>(_onValidate);
    // on<AnalyzeHabitGoal>(_onAnalyzeHabit);
  }

  void _onHabitNameChanged(
    ChangeHabitName event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitNameChanged(current: state, habitName: event.habitName));
  }

  void _onHabitDescChanged(
    ChangeHabitDesc event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitDescChanged(current: state, habitDesc: event.desc));
  }

  void _onChangeHabitGoal(
    ChangeHabitGoal event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitGoalDescChanged(current: state, habitGoalDesc: event.goalDesc));
  }

  void _onChangeGoalType(
    ChangeGoalType event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitGoalTypeChanged(current: state, goalType: event.goalType));
  }

  void _onChangeGoalTargetValue(
    ChangeGoalTargetValue event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitGoalTargetValueChanged(
      current: state,
      targetValue: event.targetValue,
    ));
  }

  void _onHabitCategory(
    ChangeHabitCategory event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitCategoryChanged(current: state, habitCategory: event.category));
  }

  void _onHabitFrequencyChanged(
    ChangeFrequency event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitFrequencyChanged(current: state, frequency: event.frequency));
  }

  void _onHabitReminderChanged(
    ChangeRemindTime event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitTimeReminderChanged(
        current: state, reminderTime: event.reminderTime));
  }

  void _onStartDateChanged(
    ChangeStartDate event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitStartDateChanged(current: state, startDate: event.startDate));
  }

  void _onEndDateChanged(
    ChangeEndDate event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitEndDateChanged(current: state, endDate: event.endDate));
  }

  _onValidate(
    ValidateHabit event,
    Emitter<ValidateHabitState> emit,
  ) async {
    if (state.habitName.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.habitDesc.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.habitGoal.goalDesc.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.habitGoal.goalType.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.habitGoal.targetValue <= 0) {
      emit(ValidateFailed(
          current: state,
          errorMessage: 'Goal target value must be greater than 0'));
      return;
    }

    if (state.habitGoal.goalUnit.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.habitCategory.isEmpty) {
      emit(ValidateFailed(current: state, errorMessage: S.current.empty_field));
      return;
    }

    if (state.startDate.isAfter(state.endDate)) {
      emit(ValidateFailed(
          current: state, errorMessage: 'Start date cannot be after end date'));
      return;
    }

    if (state.endDate.difference(state.startDate).inDays < 1) {
      emit(ValidateFailed(
          current: state,
          errorMessage: 'Habit duration must be at least 1 day'));
      return;
    }

    if (state.reminderTime.isEmpty) {
      emit(ValidateFailed(
          current: state, errorMessage: 'Reminder time must be set'));
      return;
    }

    if (state.habitGoal.goalFrequency <= 0) {
      emit(ValidateFailed(
          current: state, errorMessage: 'Frequency must be greater than 0'));
      return;
    }

    final habitId = const Uuid().v4();
    final reminderTime = HabitTimeOfDay.stringToTimeOfDay(state.reminderTime);
    final habit = HabitEntity(
      habitId: habitId,
      habitTitle: state.habitName,
      habitDesc: state.habitDesc,
      habitGoal: state.habitGoal.copyWith(
        goalId: const Uuid().v4(),
        habitId: habitId,
      ),
      habitCategory: state.habitCategory,
      timeOfDay: HabitTimeOfDay.getPartOfDay(reminderTime) ??
          HabitTimeOfDay.anytime.name,
      reminderTime: DateTime.now()
          .copyWith(hour: reminderTime.hour, minute: reminderTime.minute),
      habitStatus: DateTime.now().isBefore(state.startDate)
          ? HabitStatus.pending.name
          : HabitStatus.inProgress.name,
      startDate: state.startDate,
      endDate: state.endDate,
    );

    emit(ValidateSucceed(current: state));
    habitRepository.createHabit(HabitModel.fromEntity(habit));
    final repo = await habitRepository.getHabitById(habit.habitId);
    print('REPO: $repo');
  }

  void _onHabitUnitChange(
    ChangeGoalTargetUnit event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitGoalUnitChanged(current: state, unit: event.unit));
  }
}
