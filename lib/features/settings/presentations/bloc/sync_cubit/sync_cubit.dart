import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../services/api_service.dart';
import '../../../../habit/data/models/habit_history_model.dart';
import '../../../../habit/data/models/habit_model.dart';
import '../../../../habit/domain/repositories/habit_history_repository.dart';
import '../../../../habit/domain/repositories/habit_repository.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  final connectionChecker = InternetConnectionChecker.instance;
  final _appLogger = getIt.get<AppLogger>();

  SyncCubit(
    this._habitRepository,
    this._habitHistoryRepository,
  ) : super(SyncInitial());

  final HabitRepository _habitRepository;
  final HabitHistoryRepository _habitHistoryRepository;
  ApiService<HabitModel>? _habitApiService;
  ApiService<HabitHistoryModel>? _historyApiService;

  Future<void> syncAll(String? email) async {
    try {
      emit(SyncInProgress());
      if (!await _checkInternetConnection()) {
        emit(SyncFailure(S.current.internet_failure_title));
        return;
      }

      if (email == null || email.isEmpty) {
        emit(SyncFailure(S.current.invalid_email));
        return;
      }

      _habitApiService = getIt.get<ApiService<HabitModel>>(param1: email);
      _historyApiService =
          getIt.get<ApiService<HabitHistoryModel>>(param1: email);

      bool isHabitsSync = await _syncHabit();
      bool isHistoriesSync = await _syncHistory();

      if (!isHabitsSync || !isHistoriesSync) {
        emit(SyncFailure(S.current.sync_failed));
        return;
      }

      bool isSyncToFirestore = await _syncAllPendingToFirestore();

      if (!isSyncToFirestore) {
        emit(SyncFailure(S.current.sync_failed));
        return;
      }

      emit(SyncSuccess(S.current.sync_success));
    } catch (e) {
      _appLogger.e(e);
      emit(SyncFailure('Cannot sync the data: $e'));
    }
  }

  Future<bool> _syncAllPendingToFirestore() async {
    try {
      final unsyncedHabits = (await _habitRepository.getAllHabits())
          .where((h) => h.remoteUpdatedAt == null)
          .toList();
      final unsyncedLogs = (await _habitHistoryRepository.getHabitHistories())
          .where((l) => l.remoteUpdatedAt == null)
          .toList();

      for (var habit in unsyncedHabits) {
        await _habitApiService!.createById(
          id: habit.habitId,
          data: habit.copyWith(remoteUpdatedAt: DateTime.now()).toJson(),
        );
      }

      for (var history in unsyncedLogs) {
        await _historyApiService!.createById(
          id: history.id,
          data: history.copyWith(remoteUpdatedAt: DateTime.now()).toJson(),
        );
      }

      return true;
    } catch (e) {
      _appLogger.e('Failed to sync $e');
      return false;
    }
  }

  Future<bool> _checkInternetConnection() async {
    try {
      return await connectionChecker.hasConnection;
    } catch (e) {
      _appLogger.e(e);
      return false;
    }
  }

  Future<bool> _syncHabit() async {
    try {
      final dataState = await _habitApiService!.getAll();

      if (dataState is DataFailure || dataState.data == null) {
        _appLogger.i('No data found');
        return false;
      }

      final remoteHabits = dataState.data!;

      for (var remoteHabit in remoteHabits) {
        var localHabit =
            await _habitRepository.getHabitById(remoteHabit.habitId);
        if (localHabit == null) {
          await _habitRepository.createHabit(remoteHabit);
        } else if (localHabit.remoteUpdatedAt == null ||
            (remoteHabit.remoteUpdatedAt ?? DateTime.now())
                .isAfter(localHabit.remoteUpdatedAt!)) {
          final syncHabit = localHabit.copyWith(
            habitTitle: remoteHabit.habitTitle,
            habitDesc: remoteHabit.habitDesc,
            currentStreak: remoteHabit.currentStreak,
            longestStreak: remoteHabit.longestStreak,
            habitStatus: remoteHabit.habitStatus,
            habitProgress: remoteHabit.habitProgress,
            remoteUpdatedAt: DateTime.now(),
          );
          await _habitRepository.updateHabit(syncHabit.habitId, syncHabit);
        }
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _syncHistory() async {
    try {
      final dataState = await _historyApiService!.getAll();

      if (dataState is DataFailure || dataState.data == null) {
        _appLogger.i('No data found');
        return false;
      }

      final remoteHistories = dataState.data!;

      for (var remoteHistory in remoteHistories) {
        var localHistory =
            await _habitHistoryRepository.getHabitHistoryById(remoteHistory.id);

        if (localHistory == null) {
          await _habitHistoryRepository.createHabitHistory(remoteHistory);
        } else if (localHistory.remoteUpdatedAt == null ||
            (remoteHistory.remoteUpdatedAt ?? DateTime.now())
                .isAfter(localHistory.remoteUpdatedAt!)) {
          final syncHistory = localHistory.copyWith(
            mood: () => remoteHistory.mood,
            executionStatus: remoteHistory.executionStatus,
            note: () => remoteHistory.note,
            currentValue: remoteHistory.currentValue,
            remoteUpdatedAt: DateTime.now(),
          );
          await _habitHistoryRepository.updateHabitHistory(syncHistory);
        }
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
