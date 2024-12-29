import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/habit_history_model.dart';
import '../../../domain/entities/habit_history.dart';
import '../../../domain/repositories/habit_history_repository.dart';

part 'habit_history_crud_event.dart';
part 'habit_history_crud_state.dart';

class HabitHistoryCrudBloc
    extends Bloc<HabitHistoryCrudEvent, HabitHistoryCrudState> {
  final HabitHistoryRepository habitHistoryRepository;
  HabitHistoryCrudBloc(this.habitHistoryRepository)
      : super(HabitHistoryCrudInitial()) {
    on<HabitHistoryCrudCreate>(_onCreateHistory);
    on<HabitHistoryCrudListByHabitId>(_onGetHistoriesByHabitId);
    on<GetTodayHabitHistory>(_onGetTodayHabitHistory);
    on<AddWaterHabitHistory>(_onAddWaterHabit);
    on<SetHabitHistoryStatus>(_onSetHabitHistoryStatus);
  }

  final _appLogger = getIt.get<AppLogger>();

  FutureOr<void> _onCreateHistory(
      HabitHistoryCrudCreate event, Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      await habitHistoryRepository
          .createHabitHistory(HabitHistoryModel.fromEntity(event.habitHistory));

      final createdHistory = await habitHistoryRepository
          .getHabitHistoryById(event.habitHistory.id);

      if (createdHistory == null) {
        emit(HabitHistoryCrudFailure(S.current.cannot_store_history));
      } else {
        emit(
          HabitHistoryCrudSuccess(
              HabitHistoryCrudEventType.create, [createdHistory.toEntity()]),
        );
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetHistoriesByHabitId(HabitHistoryCrudListByHabitId event,
      Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final histories = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      emit(HabitHistoryCrudSuccess(HabitHistoryCrudEventType.list,
          histories.map((e) => e.toEntity()).toList()));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onAddWaterHabit(
      AddWaterHabitHistory event, Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final histories = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      final todayHistory = histories.firstWhere(
        (element) =>
            element.date.toMoment().isAtSameDayAs(DateTime.now().toMoment()),
        orElse: () => HabitHistoryModel.fromEntity(HabitHistory.init()),
      );

      final currentValue = todayHistory.currentValue + event.quantity;

      if (currentValue >= event.targetValue) {
        emit(DailyHabitCompleted());
      }

      final updatedHistory = todayHistory.copyWith(
        habitId: event.habitId,
        quantity: () => event.targetValue.toDouble(),
        currentValue: currentValue,
        executionStatus:
            todayHistory.executionStatus != DayStatus.completed.name &&
                    currentValue >= (todayHistory.quantity ?? 0)
                ? DayStatus.completed.name
                : DayStatus.inProgress.name,
      );

      if (todayHistory.id.isEmpty) {
        await habitHistoryRepository
            .createHabitHistory(HabitHistoryModel.fromEntity(updatedHistory));
      } else {
        await habitHistoryRepository
            .updateHabitHistory(HabitHistoryModel.fromEntity(updatedHistory));
      }

      emit(HabitHistoryCrudSuccess(
          HabitHistoryCrudEventType.update, [todayHistory.toEntity()]));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetTodayHabitHistory(
      GetTodayHabitHistory event, Emitter<HabitHistoryCrudState> emit) async {
    try {
      List<HabitHistoryModel> habits = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      habits = habits.where((e) => DateTimeHelper.isToday(e.date)).toList();

      HabitHistoryModel todayHistory;
      if (habits.isEmpty) {
        todayHistory = HabitHistoryModel.fromEntity(
            HabitHistory.init().copyWith(habitId: event.habitId));

        await habitHistoryRepository.createHabitHistory(todayHistory);
      } else {
        todayHistory = habits.first;
      }

      emit(HabitHistoryCrudSuccess(
          HabitHistoryCrudEventType.read, [todayHistory.toEntity()]));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(S.current.cannot_get_any_history));
    }
  }

  FutureOr<void> _onSetHabitHistoryStatus(
      SetHabitHistoryStatus event, Emitter<HabitHistoryCrudState> emit) async {
    try {
      HabitHistoryModel? habit =
          await habitHistoryRepository.getHabitHistoryById(event.historyId);

      if (habit == null) {
        emit(HabitHistoryCrudFailure(S.current.history_empty));
      } else {
        habit = habit.copyWith(executionStatus: event.status);
        await habitHistoryRepository.updateHabitHistory(habit);

        if (event.status == DayStatus.completed) {
          emit(DailyHabitCompleted());
        } else {
          emit(DailyHabitPaused());
        }

        emit(HabitHistoryCrudSuccess(
            HabitHistoryCrudEventType.update, [habit.toEntity()]));
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(S.current.cannot_get_any_history));
    }
  }
}
