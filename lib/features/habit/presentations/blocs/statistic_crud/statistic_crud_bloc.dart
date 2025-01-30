import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../rewards/domain/repositories/achievement_repository.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_history.dart';
import '../../../domain/repositories/habit_history_repository.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'statistic_crud_event.dart';
part 'statistic_crud_state.dart';

class StatisticCrudBloc extends Bloc<StatisticCrudEvent, StatisticCrudState> {
  final HabitRepository habitRepository;
  final AchievementRepository achievementRepository;
  final HabitHistoryRepository habitHistoryRepository;

  StatisticCrudBloc({
    required this.habitRepository,
    required this.achievementRepository,
    required this.habitHistoryRepository,
  }) : super(StatisticCrudInitial()) {
    on<LoadBriefStatistic>(_onLoadBriefStatistic);
    on<LoadGeneralStatistic>(_onLoadGeneralStatistic);
  }

  final _appLogger = getIt.get<AppLogger>();

  Future<void> _onLoadBriefStatistic(
      LoadBriefStatistic event, Emitter<StatisticCrudState> emit) async {
    try {
      emit(StatisticLoading());

      emit(BriefStatisticLoaded(
        totalHabits: (await _getAllHabits()).length,
        longestStreak: await _getLongestStreak(),
        totalAchievements: await _getTotalAchievement(),
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<void> _onLoadGeneralStatistic(
      LoadGeneralStatistic event, Emitter<StatisticCrudState> emit) async {
    try {
      emit(StatisticLoading());
      // Get total habits
      final allHabits = await _getAllHabits();
      final activeHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.inProgress);
      final failedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.failed);
      final pausedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.paused);
      final achievedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.achieved);

      // Completion Rate
      final allHistories = await habitHistoryRepository.getHabitHistories();
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      final currentWeekHistories = allHistories
          .where(
              (e) => e.date.isAfter(startOfWeek) && e.date.isBefore(endOfWeek))
          .toList();

      DateTime startOfPreviousWeek =
          startOfWeek.subtract(const Duration(days: 7));
      DateTime endOfPreviousWeek =
          startOfWeek.subtract(const Duration(days: 1));

      List<HabitHistory> previousWeekHistories = allHistories
          .where((e) =>
              e.date.isAfter(startOfPreviousWeek) &&
              e.date.isBefore(endOfPreviousWeek))
          .toList();

      var stats = calculateCompletionStats(
        currentWeekHistories,
        previousWeekHistories,
      );

      emit(GeneralStatisticLoaded(
        totalHabits: allHabits.length,
        activeHabits: activeHabits.length,
        pausedHabits: pausedHabits.length,
        failedHabits: failedHabits.length,
        achievedHabits: achievedHabits.length,
        longestStreak: await _getLongestStreak(),
        totalAchievements: await _getTotalAchievement(),
        completionRate: stats.currentRate,
        completionRateTrend: stats.relativeChange,
        allHistories: allHistories.map((e) => e.toEntity()).toList(),
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<List<HabitModel>> _getAllHabits() async =>
      await habitRepository.getAllHabits();

  Future<int> _getLongestStreak() async => (await _getAllHabits())
      .reduce(
          (prev, curr) => prev.longestStreak > curr.longestStreak ? prev : curr)
      .longestStreak;

  Future<int> _getTotalAchievement() async =>
      (await achievementRepository.getAllLocalAchievements())
          .where((e) => e.isUnlocked)
          .length;

  static CompletionStats calculateCompletionStats(
    List<HabitHistory> currentWeekHistories,
    List<HabitHistory> previousWeekHistories,
  ) {
    // Calculate current week completion rate
    double currentWeekRate =
        _calculateWeeklyCompletionRate(currentWeekHistories);

    // Calculate previous week completion rate
    double previousWeekRate =
        _calculateWeeklyCompletionRate(previousWeekHistories);

    // Calculate the difference (as percentage points)
    double difference = currentWeekRate - previousWeekRate;

    // Calculate the relative change (as a percentage)
    double relativeChange = previousWeekRate != 0
        ? ((currentWeekRate - previousWeekRate) / previousWeekRate) * 100
        : 0;

    return CompletionStats(
      currentRate: currentWeekRate,
      previousRate: previousWeekRate,
      difference: difference,
      relativeChange: relativeChange,
      trend: difference > 0
          ? 'up'
          : difference < 0
              ? 'down'
              : 'same',
    );
  }

  /// Calculates the completion rate for a single week
  static double _calculateWeeklyCompletionRate(List<HabitHistory> histories) {
    if (histories.isEmpty) return 0;

    int totalCompleted = histories
        .where((history) => history.executionStatus == DayStatus.completed)
        .length;

    return (totalCompleted / histories.length) * 100;
  }

  /// Calculate completion rates grouped by habit
  static Map<String, CompletionStats> calculateCompletionStatsByHabit(
    Map<String, List<HabitHistory>> currentWeekHistoriesByHabit,
    Map<String, List<HabitHistory>> previousWeekHistoriesByHabit,
  ) {
    Map<String, CompletionStats> results = {};

    for (var habitId in currentWeekHistoriesByHabit.keys) {
      var currentHistories = currentWeekHistoriesByHabit[habitId] ?? [];
      var previousHistories = previousWeekHistoriesByHabit[habitId] ?? [];

      results[habitId] = calculateCompletionStats(
        currentHistories,
        previousHistories,
      );
    }

    return results;
  }
}

class CompletionStats {
  final double currentRate;
  final double previousRate;
  final double difference;
  final double relativeChange;
  final String trend;

  CompletionStats({
    required this.currentRate,
    required this.previousRate,
    required this.difference,
    required this.relativeChange,
    required this.trend,
  });
}
