import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/constants/app_storage_key.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/enums/habit/mood.dart';
import '../../../../../core/helpers/cached_client.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/habit_history_model.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/entities/habit_history.dart';
import '../../../domain/repositories/habit_history_repository.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'habit_history_crud_event.dart';
part 'habit_history_crud_state.dart';

class HabitHistoryCrudBloc
    extends Bloc<HabitHistoryCrudEvent, HabitHistoryCrudState> {
  final HabitHistoryRepository habitHistoryRepository;
  final HabitRepository habitRepository;
  final CacheClient cacheClient;

  HabitHistoryCrudBloc({
    required this.habitHistoryRepository,
    required this.habitRepository,
    required this.cacheClient,
  }) : super(HabitHistoryCrudInitial()) {
    on<HabitHistoryCrudCreate>(_onCreateHistory);
    on<HabitHistoryCrudListByHabitId>(_onGetHistoriesByHabitId);
    on<GetTodayHabitHistory>(_onGetTodayHabitHistory);
    on<AddWaterHabitHistory>(_onAddWaterHabit);
    on<SetHabitHistoryStatus>(_onSetHabitHistoryStatus);
    on<SearchHabitsByFilter>(_onSearchHabitByFilter);
    on<HabitHistoryCrudUpdate>(_onUpdateHistory);
    on<DeleteAllHistoriesByHabitId>(_onDeleteAllByHabitId);
    on<CheckDailyStreaks>(_onCheckDailyStreaks);
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
        emit(HabitHistoryCrudSuccess(
            HabitHistoryCrudEventType.create, [createdHistory.toEntity()]));
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

      emit(HabitHistoryCrudSuccess(
        HabitHistoryCrudEventType.list,
        histories.map((e) => e.toEntity()).toList()
          ..sort((a, b) => b.date.compareTo(a.date)),
      ));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onAddWaterHabit(
    AddWaterHabitHistory event,
    Emitter<HabitHistoryCrudState> emit,
  ) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final todayHistory = await _getOrCreateTodayHistory(event.habitId);
      final updatedHistory = _updateWaterHabitHistory(todayHistory, event);

      await _persistHabitHistory(updatedHistory);

      final currentHabit = await _updateParentHabit(
        updatedHistory.habitId,
        updatedHistory.executionStatus == DayStatus.completed,
      );
      if (currentHabit == null) {
        emit(HabitHistoryCrudFailure(S.current.cannot_get_any_habit));
        return;
      }

      final historyEntity = updatedHistory.toEntity();

      emit(HabitHistoryCrudSuccess(
        HabitHistoryCrudEventType.update,
        [historyEntity],
      ));

      if (updatedHistory.executionStatus == DayStatus.completed) {
        emit(DailyHabitCompleted(historyEntity));
      } else if (updatedHistory.executionStatus == DayStatus.skipped) {
        emit(DailyHabitSkipped(historyEntity));
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  Future<HabitHistoryModel> _getOrCreateTodayHistory(String habitId) async {
    final histories =
        await habitHistoryRepository.getHabitHistoriesByHabitId(habitId);
    return histories.firstWhere(
      (element) =>
          element.date.toMoment().isAtSameDayAs(DateTime.now().toMoment()),
      orElse: () => HabitHistoryModel.fromEntity(HabitHistory.init()),
    );
  }

  HabitHistoryModel _updateWaterHabitHistory(
    HabitHistoryModel history,
    AddWaterHabitHistory event,
  ) {
    double targetValue = event.targetValue;

    final currentValue = history.currentValue + event.quantity;
    final isCompleted = currentValue >= targetValue;

    return history.copyWith(
      habitId: event.habitId,
      targetValue: () => targetValue.toDouble(),
      currentValue: currentValue,
      executionStatus: isCompleted ? DayStatus.completed : DayStatus.inProgress,
      endTime: isCompleted ? () => DateTime.now() : null,
    );
  }

  Future<void> _persistHabitHistory(HabitHistoryModel history) async {
    if (history.id.isEmpty || history == HabitHistory.init()) {
      await habitHistoryRepository
          .createHabitHistory(history.copyWith(id: const Uuid().v4()));
    } else {
      await habitHistoryRepository.updateHabitHistory(history);
    }
  }

  FutureOr<void> _onGetTodayHabitHistory(
    GetTodayHabitHistory event,
    Emitter<HabitHistoryCrudState> emit,
  ) async {
    try {
      List<HabitHistoryModel> habits = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      habits = habits.where((e) => DateTimeHelper.isToday(e.date)).toList();

      HabitHistoryModel todayHistory;
      if (habits.isEmpty) {
        todayHistory = HabitHistoryModel.fromEntity(
          HabitHistory.init().copyWith(
            id: const Uuid().v4(),
            habitId: event.habitId,
            measurement: () => event.unit,
            targetValue: () => event.targetValue,
          ),
        );

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

  Future<void> _onSetHabitHistoryStatus(
    SetHabitHistoryStatus event,
    Emitter<HabitHistoryCrudState> emit,
  ) async {
    try {
      final isCompleted = event.status == DayStatus.completed;
      final history = await _updateHabitHistory(event);
      if (history == null) {
        emit(HabitHistoryCrudFailure(S.current.history_empty));
        return;
      }

      final currentHabit = await _updateParentHabit(
        history.habitId,
        isCompleted,
      );
      if (currentHabit == null) {
        emit(HabitHistoryCrudFailure(S.current.cannot_get_any_habit));
        return;
      }

      final historyEntity = history.toEntity();

      emit(
        HabitHistoryCrudSuccess(
          HabitHistoryCrudEventType.update,
          [historyEntity],
        ),
      );

      if (isCompleted) {
        emit(DailyHabitCompleted(historyEntity));
      } else if (event.status == DayStatus.skipped) {
        emit(DailyHabitSkipped(historyEntity));
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(S.current.cannot_get_any_history));
    }
  }

  Future<HabitHistoryModel?> _updateHabitHistory(
    SetHabitHistoryStatus event,
  ) async {
    final habit =
        await habitHistoryRepository.getHabitHistoryById(event.historyId);
    if (habit == null) return null;

    final updatedHabit = habit.copyWith(
      executionStatus: event.status,
      currentValue: event.status == DayStatus.completed
          ? habit.targetValue
          : habit.currentValue,
      endTime: () => DateTime.now(),
    );

    await habitHistoryRepository.updateHabitHistory(updatedHabit);
    return updatedHabit;
  }

  Future<HabitModel?> _updateParentHabit(
    String habitId,
    bool isCompleted,
  ) async {
    final habit = await habitRepository.getHabitById(habitId);
    if (habit == null) return null;

    final updatedHabit = habit.copyWith(
      currentStreak: isCompleted ? habit.currentStreak + 1 : 0,
      longestStreak: max(
        isCompleted ? habit.currentStreak + 1 : habit.currentStreak,
        habit.longestStreak,
      ),
      habitProgress: await _updateProgress(habit),
      habitGoal: habit.habitGoal.copyWith(
          goalFrequency: habit.habitGoal.goalFrequency.copyWith(
        lastCompletionTime: DateTime.now(),
      )),
    );

    await habitRepository.updateHabit(habitId, updatedHabit);
    return updatedHabit;
  }

  Future<double> _updateProgress(HabitModel habit) async {
    final int totalDays = habit.endDate.difference(habit.startDate).inDays + 1;
    List<HabitHistoryModel> histories =
        await habitHistoryRepository.getHabitHistoriesByHabitId(habit.habitId);

    final int completedDays = histories
        .where((h) =>
            h.executionStatus == DayStatus.completed &&
            h.date.isAfter(habit.startDate.subtract(const Duration(days: 1))) &&
            h.date.isBefore(habit.endDate.add(const Duration(days: 1))))
        .length;

    return completedDays / totalDays;
  }

  Future<void> _onCheckDailyStreaks(
    CheckDailyStreaks event,
    Emitter<HabitHistoryCrudState> emit,
  ) async {
    try {
      final lastCheckMillis =
          cacheClient.getInt(AppStorageKey.lastCheckStreakKey);
      final now = DateTime.now();
      final lastCheck = lastCheckMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(lastCheckMillis)
          : now.subtract(const Duration(days: 1));

      final habits =
          await habitRepository.getHabitsByStatus(HabitStatus.inProgress.name);

      final List<HabitEntity> updatedHabits = [];

      for (var habit in habits) {
        final histories =
            (await habitHistoryRepository.getHabitHistoriesByDateRange(
                    habitId: habit.habitId, startDate: lastCheck, endDate: now))
                .toList();

        final existingStatuses = {
          for (var h in histories)
            DateTime(h.date.year, h.date.month, h.date.day): h.executionStatus
        };

        final existingDates = histories
            .map((h) => DateTime(
                  h.date.year,
                  h.date.month,
                  h.date.day,
                ))
            .toSet();

        final missingHistories = HabitHistory.fillMissingHistoryRecords(
          habitId: habit.habitId,
          startDate: lastCheck,
          endDate: now.subtract(const Duration(days: 1)),
          existingDates: existingDates,
          existingStatuses: existingStatuses,
          measurement: habit.habitGoal.goalUnit,
          targetValue: habit.habitGoal.targetValue,
        );

        for (var history in missingHistories) {
          final date = DateTime(
            history.date.year,
            history.date.month,
            history.date.day,
          );
          if (existingStatuses[date] == DayStatus.inProgress) {
            await habitHistoryRepository.deleteHabitHistoryByDate(
              habitId: habit.habitId,
              date: date,
            );
          }
        }

        for (var history in missingHistories) {
          await habitHistoryRepository
              .createHabitHistory(HabitHistoryModel.fromEntity(history));
        }

        var updatedHabit = habit;

        if (missingHistories.isNotEmpty ||
            !_hasCompletedHistoryForDate(
                histories, now.subtract(const Duration(days: 1)))) {
          updatedHabit = habit.copyWith(
            currentStreak: 0,
            longestStreak: habit.longestStreak > habit.currentStreak
                ? habit.longestStreak
                : habit.currentStreak,
          );
        }

        updatedHabits.add(updatedHabit);
        await habitRepository.updateHabit(updatedHabit.habitId, updatedHabit);
      }

      await cacheClient.setInt(
          AppStorageKey.lastCheckStreakKey, now.millisecondsSinceEpoch);
    } catch (e) {
      emit(HabitHistoryCrudFailure('Failed to update streaks: $e'));
    }
  }

  bool _hasCompletedHistoryForDate(
      List<HabitHistory> histories, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return histories.any((history) =>
        DateTime(history.date.year, history.date.month, history.date.day)
            .isAtSameMomentAs(normalizedDate) &&
        history.executionStatus == DayStatus.completed);
  }

  FutureOr<void> _onSearchHabitByFilter(
      SearchHabitsByFilter event, Emitter<HabitHistoryCrudState> emit) async {
    try {
      emit(HabitHistoryCrudInProgress());
      List<HabitHistory> histories = (await habitHistoryRepository
              .getHabitHistoriesByHabitId(event.habitId))
          .map((e) => e.toEntity())
          .toList();

      if (event.status != null) {
        histories = histories
            .where((history) => history.executionStatus == event.status)
            .toList();
      }

      if (event.mood != null) {
        histories =
            histories.where((history) => history.mood == event.mood).toList();
      }

      const separatedPattern = ' - ';
      if (event.date?.isNotEmpty ?? false) {
        if (event.date!.contains(separatedPattern)) {
          final dates = event.date!.split(separatedPattern);
          final startDate = DateTime.tryParse(dates.first);
          final stopDate = DateTime.tryParse(dates.last) ?? DateTime.now();

          histories = histories
              .where((history) =>
                  history.date
                      .isAfter(startDate!.subtract(const Duration(days: 1))) &&
                  history.date.isBefore(stopDate.add(const Duration(days: 1))))
              .toList();
        } else {
          final date = DateTime.tryParse(event.date!);
          if (date != null) {
            histories = histories
                .where((history) => history.date.isAtSameDayAs(date))
                .toList();
          }
        }
      }

      emit(HabitHistoryCrudSuccess(HabitHistoryCrudEventType.list, histories));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(S.current.cannot_get_any_history));
    }
  }

  FutureOr<void> _onUpdateHistory(
      HabitHistoryCrudUpdate event, Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final currentHistory = await habitHistoryRepository
          .getHabitHistoryById(event.habitHistory.id);
      if (currentHistory == null) {
        emit(HabitHistoryCrudFailure(S.current.cannot_get_any_history));
      } else {
        await habitHistoryRepository.updateHabitHistory(
            HabitHistoryModel.fromEntity(event.habitHistory));
        final updated = await habitHistoryRepository
            .getHabitHistoryById(event.habitHistory.id);

        if (updated == null) {
          emit(const HabitHistoryCrudFailure('Cannot update history'));
          return;
        }

        emit(HabitHistoryCrudSuccess(
            HabitHistoryCrudEventType.update, [updated.toEntity()]));
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(const HabitHistoryCrudFailure('Cannot update history'));
    }
  }

  FutureOr<void> _onDeleteAllByHabitId(DeleteAllHistoriesByHabitId event,
      Emitter<HabitHistoryCrudState> emit) async {
    try {
      final histories = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      if (histories.isNotEmpty) {
        for (var history in histories) {
          await habitHistoryRepository.deleteHabitHistory(history.id);
        }

        emit(
          HabitHistoryCrudSuccess(
            HabitHistoryCrudEventType.delete,
            histories.map((e) => e.toEntity()).toList(),
          ),
        );
      } else {
        emit(HabitHistoryCrudSuccess(HabitHistoryCrudEventType.delete, []));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }
}
