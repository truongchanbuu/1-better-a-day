import 'dart:async';

import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/enums/habit/goal_type.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/extensions/time_of_day_extension.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/entities/habit_frequency.dart';
import '../../../domain/entities/habit_goal.dart';
import '../../../domain/entities/habit_icon.dart';
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
    on<ChangeHabitIcon>(_onHabitIconChanged);
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
    emit(
        HabitFrequencyChanged(current: state, habitFrequency: event.frequency));
  }

  void _onHabitReminderChanged(
    ChangeRemindTime event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitTimeReminderChanged(
        current: state, reminderTimes: event.reminderTimes));
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
    HabitTimeOfDay getTimeOfDay() {
      if (state.reminderTimes.isEmpty) return HabitTimeOfDay.anytime;
      if (state.reminderTimes.length == 1) {
        return HabitTimeOfDay.getPartOfDay(
                TimeOfDayExtension.tryParse(state.reminderTimes.first)) ??
            HabitTimeOfDay.anytime;
      }

      return HabitTimeOfDay.anytime;
    }

    emit(Validating(state));
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

    if (state.habitGoal.targetValue <= 0) {
      emit(ValidateFailed(
          current: state,
          errorMessage: 'Goal target value must be greater than 0'));
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

    if (!state.habitGoal.goalFrequency.isValid) {
      emit(ValidateFailed(
          current: state, errorMessage: 'Frequency must be greater than 0'));
      return;
    }

    emit(ValidateSucceed(current: state));

    final habitId = const Uuid().v4();
    final habit = HabitEntity(
      habitId: habitId,
      habitTitle: state.habitName,
      habitDesc: state.habitDesc,
      habitGoal: state.habitGoal.copyWith(
        goalId: const Uuid().v4(),
        habitId: habitId,
      ),
      habitCategory: state.habitCategory,
      timeOfDay: getTimeOfDay(),
      habitStatus: DateTime.now().isBefore(state.startDate)
          ? HabitStatus.pending
          : HabitStatus.inProgress,
      startDate: state.startDate,
      endDate: state.endDate,
      habitIcon: state.habitIcon,
      reminderTimes: state.reminderTimes,
    );

    await habitRepository.createHabit(HabitModel.fromEntity(
        habit.copyWith(habitStatus: HabitStatus.inProgress)));
    final createdHabit = await habitRepository.getHabitById(habit.habitId);
    if (createdHabit != null) {
      emit(HabitAdded(createdHabit));
    } else {
      emit(HabitAddFailed(errorMessage: S.current.cannot_generate_habit));
    }
  }

  void _onHabitUnitChange(
    ChangeGoalTargetUnit event,
    Emitter<ValidateHabitState> emit,
  ) {
    emit(HabitGoalUnitChanged(current: state, unit: event.unit));
  }

  FutureOr<void> _onHabitIconChanged(
      ChangeHabitIcon event, Emitter<ValidateHabitState> emit) {
    emit(HabitIconChanged(current: state, habitIcon: event.habitIcon));
  }
}
