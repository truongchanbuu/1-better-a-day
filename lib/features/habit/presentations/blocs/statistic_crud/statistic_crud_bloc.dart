import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../rewards/domain/repositories/achievement_repository.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
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
    on<LoadActiveStatistic>(_onLoadActiveStatistic);
    on<LoadPauseStatistic>(_onLoadPauseStatistic);
    on<LoadFailedStatistic>(_onLoadFailedStatistic);
    on<LoadAchievedStatistic>(_onLoadAchievedStatistic);
  }

  final _appLogger = getIt.get<AppLogger>();

  Future<void> _onLoadBriefStatistic(
      LoadBriefStatistic event, Emitter<StatisticCrudState> emit) async {
    // try {
    //   emit(StatisticLoading());
    //
    //   emit(BriefStatisticLoaded(
    //     totalHabits: (await _getAllHabits()).length,
    //     longestStreak: await _getLongestStreak(),
    //     totalAchievements: await _getTotalAchievement(),
    //   ));
    // } catch (e) {
    //   _appLogger.e(e);
    //   emit(StatisticLoadFailed(S.current.not_found));
    // }
    emit(StatisticLoading());

    emit(BriefStatisticLoaded(
      totalHabits: (await _getAllHabits()).length,
      longestStreak: await _getLongestStreak(),
      totalAchievements: await _getTotalAchievement(),
    ));
  }

  Future<void> _onLoadGeneralStatistic(
    LoadGeneralStatistic event,
    Emitter<StatisticCrudState> emit,
  ) async {
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

      var stats = calculateStatsByStatus(
        currentWeekHistories,
        previousWeekHistories,
      );

      var overallCompletionRate = _calculateRateHabitsByStatus(allHabits);

      emit(GeneralStatisticLoaded(
        totalHabits: allHabits.length,
        activeHabits: activeHabits.length,
        pausedHabits: pausedHabits.length,
        failedHabits: failedHabits.length,
        achievedHabits: achievedHabits.length,
        longestStreak: await _getLongestStreak(),
        totalAchievements: await _getTotalAchievement(),
        weeklyCompletionRate: stats.currentRate,
        overallCompletionRate: overallCompletionRate,
        completionRateTrend: stats.relativeChange,
        allHistories: allHistories.map((e) => e.toEntity()).toList(),
        allHabits: allHabits.map((e) => e.toEntity()).toList(),
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<void> _onLoadActiveStatistic(
    LoadActiveStatistic event,
    Emitter<StatisticCrudState> emit,
  ) async {
    try {
      final allHabits =
          (await _getAllHabits()).map((e) => e.toEntity()).toList();
      final activeHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.inProgress);

      final habitData = _getHabitData(allHabits, HabitStatus.inProgress);

      emit(ActiveStatisticLoaded(
        activeHabits: activeHabits.length,
        habitData: habitData,
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<void> _onLoadPauseStatistic(
      LoadPauseStatistic event, Emitter<StatisticCrudState> emit) async {
    try {
      final allHabits =
          (await _getAllHabits()).map((e) => e.toEntity()).toList();
      final pausedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.paused);
      final habitData = _getHabitData(allHabits, HabitStatus.paused);

      emit(PausedStatisticLoaded(
        pausedHabits: pausedHabits.length,
        habitData: habitData,
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<void> _onLoadFailedStatistic(
    LoadFailedStatistic event,
    Emitter<StatisticCrudState> emit,
  ) async {
    try {
      final allHabits =
          (await _getAllHabits()).map((e) => e.toEntity()).toList();
      final failedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.failed);

      double failedRate = _calculateRateHabitsByStatus(allHabits);
      final habitData = _getHabitData(allHabits, HabitStatus.failed);

      emit(FailedStatisticLoaded(
        failedHabits: failedHabits.length,
        overallFailedRate: failedRate,
        habitData: habitData,
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<void> _onLoadAchievedStatistic(
    LoadAchievedStatistic event,
    Emitter<StatisticCrudState> emit,
  ) async {
    try {
      final allHabits =
          (await _getAllHabits()).map((e) => e.toEntity()).toList();
      final achievedHabits =
          allHabits.where((e) => e.habitStatus == HabitStatus.achieved);

      List<Duration> durations =
          achievedHabits.map((entry) => entry.duration).toList();

      Duration totalDuration = Duration.zero;
      Duration avgDuration = Duration.zero;
      Duration longestDuration = Duration.zero;
      Duration fastestDuration = Duration.zero;

      if (achievedHabits.isNotEmpty) {
        totalDuration = durations.reduce((a, b) => a + b);
        avgDuration = totalDuration ~/ durations.length;
        longestDuration = durations.reduce((a, b) => a > b ? a : b);
        fastestDuration = durations.reduce((a, b) => a < b ? a : b);
      }
      final habitData = _getHabitData(allHabits, HabitStatus.achieved);

      emit(AchievedStatisticLoaded(
        achievedHabits: achievedHabits.length,
        avgDuration: avgDuration,
        fastestDuration: fastestDuration,
        longestDuration: longestDuration,
        habitData: habitData,
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(StatisticLoadFailed(S.current.not_found));
    }
  }

  Future<List<HabitModel>> _getAllHabits() async =>
      await habitRepository.getAllHabits();

  Future<int> _getLongestStreak() async {
    final allHabits = await _getAllHabits();

    if (allHabits.isEmpty) return 0;
    return allHabits
        .reduce((prev, curr) =>
            prev.longestStreak > curr.longestStreak ? prev : curr)
        .longestStreak;
  }

  Future<int> _getTotalAchievement() async =>
      (await achievementRepository.getAllLocalAchievements())
          .where((e) => e.isUnlocked)
          .length;

  static StatsByStatus calculateStatsByStatus(
      List<HabitHistory> currentWeekHistories,
      List<HabitHistory> previousWeekHistories,
      [DayStatus status = DayStatus.completed]) {
    // Calculate current week completion rate
    double currentWeekRate =
        _calculateRateByStatus(currentWeekHistories, status);

    // Calculate previous week completion rate
    double previousWeekRate =
        _calculateRateByStatus(previousWeekHistories, status);

    // Calculate the difference (as percentage points)
    double difference = currentWeekRate - previousWeekRate;

    // Calculate the relative change (as a percentage)
    double relativeChange = previousWeekRate != 0
        ? ((currentWeekRate - previousWeekRate) / previousWeekRate) * 100
        : 0;

    return StatsByStatus(
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

  /// Calculates the rate based on status for a single week
  static double _calculateRateByStatus(List<HabitHistory> histories,
      [DayStatus status = DayStatus.completed]) {
    if (histories.isEmpty) return 0;

    int totalCompleted =
        histories.where((history) => history.executionStatus == status).length;

    return (totalCompleted / histories.length) * 100;
  }

  /// Calculates the rate based on status for all habits
  static double _calculateRateHabitsByStatus(List<HabitEntity> habits,
      [HabitStatus status = HabitStatus.achieved]) {
    if (habits.isEmpty) return 0;

    int totalCompleted =
        habits.where((habit) => habit.habitStatus == status).length;

    return (totalCompleted / habits.length) * 100;
  }

  /// Calculate completion rates grouped by habit
  static Map<String, StatsByStatus> calculateStatsByStatusByHabit(
    Map<String, List<HabitHistory>> currentWeekHistoriesByHabit,
    Map<String, List<HabitHistory>> previousWeekHistoriesByHabit,
  ) {
    Map<String, StatsByStatus> results = {};

    for (var habitId in currentWeekHistoriesByHabit.keys) {
      var currentHistories = currentWeekHistoriesByHabit[habitId] ?? [];
      var previousHistories = previousWeekHistoriesByHabit[habitId] ?? [];

      results[habitId] = calculateStatsByStatus(
        currentHistories,
        previousHistories,
      );
    }

    return results;
  }

  int _calculateHabitStatusCount(
    List<HabitEntity> habits,
    HabitStatus status,
  ) {
    return habits.where((habit) => habit.habitStatus == status).length;
  }

  Map<String, List<double>> _getHabitData(
    List<HabitEntity> allHabits,
    HabitStatus status,
  ) {
    final categoryData = allHabits.groupListsBy((habit) => habit.habitCategory);
    return Map.fromEntries(HabitCategory.valuesWithoutCustom.map((category) {
      final categoryHabits = categoryData[category] ?? [];
      double total = categoryHabits.length.toDouble();
      double inProgress =
          _calculateHabitStatusCount(categoryHabits, status).toDouble();

      return MapEntry(
        category.name,
        [total, inProgress],
      );
    }));
  }
}

class StatsByStatus extends Equatable {
  final double currentRate;
  final double previousRate;
  final double difference;
  final double relativeChange;
  final String trend;

  const StatsByStatus({
    required this.currentRate,
    required this.previousRate,
    required this.difference,
    required this.relativeChange,
    required this.trend,
  });

  @override
  List<Object?> get props => [
        currentRate,
        previousRate,
        difference,
        relativeChange,
        trend,
      ];
}
