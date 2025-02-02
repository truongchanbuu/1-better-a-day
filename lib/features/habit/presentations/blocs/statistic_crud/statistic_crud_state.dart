part of 'statistic_crud_bloc.dart';

/// Base state for Statistic CRUD operations
sealed class StatisticCrudState extends Equatable {
  const StatisticCrudState();

  @override
  List<Object?> get props => [];
}

/// Initial state when no action has been performed
final class StatisticCrudInitial extends StatisticCrudState {
  const StatisticCrudInitial();
}

final class StatisticLoading extends StatisticCrudState {}

final class StatisticLoadFailed extends StatisticCrudState {
  final String error;

  const StatisticLoadFailed(this.error);

  @override
  List<Object?> get props => [error];
}

final class BriefStatisticLoaded extends StatisticCrudState {
  final int totalHabits;
  final int longestStreak;
  final int totalAchievements;

  const BriefStatisticLoaded({
    required this.totalHabits,
    required this.longestStreak,
    required this.totalAchievements,
  });

  @override
  List<Object?> get props => [totalHabits, longestStreak, totalAchievements];
}

final class GeneralStatisticLoaded extends StatisticCrudState {
  final int totalHabits;
  final int activeHabits;
  final int pausedHabits;
  final int failedHabits;
  final int achievedHabits;
  final int longestStreak;
  final int totalAchievements;
  final double weeklyCompletionRate;
  final double overallCompletionRate;
  final double completionRateTrend;
  final List<HabitHistory> allHistories;
  final List<HabitEntity> allHabits;

  const GeneralStatisticLoaded({
    required this.totalHabits,
    required this.activeHabits,
    required this.pausedHabits,
    required this.failedHabits,
    required this.achievedHabits,
    required this.longestStreak,
    required this.totalAchievements,
    required this.weeklyCompletionRate,
    required this.completionRateTrend,
    required this.allHistories,
    required this.allHabits,
    required this.overallCompletionRate,
  });

  @override
  List<Object?> get props => [
        totalHabits,
        activeHabits,
        achievedHabits,
        failedHabits,
        pausedHabits,
        longestStreak,
        totalAchievements,
        weeklyCompletionRate,
        overallCompletionRate,
        completionRateTrend,
        allHistories,
      ];
}

final class ActiveStatisticLoaded extends StatisticCrudState {
  final int activeHabits;
  final Map<String, List<double>> habitData;
  const ActiveStatisticLoaded({
    required this.activeHabits,
    required this.habitData,
  });

  @override
  List<Object?> get props => [activeHabits, habitData];
}

final class PausedStatisticLoaded extends StatisticCrudState {
  final int pausedHabits;
  final Map<String, List<double>> habitData;
  const PausedStatisticLoaded({
    required this.pausedHabits,
    required this.habitData,
  });

  @override
  List<Object?> get props => [pausedHabits, habitData];
}

final class FailedStatisticLoaded extends StatisticCrudState {
  final int failedHabits;
  final double overallFailedRate;
  final Map<String, List<double>> habitData;

  const FailedStatisticLoaded({
    required this.failedHabits,
    required this.overallFailedRate,
    required this.habitData,
  });

  @override
  List<Object?> get props => [failedHabits, overallFailedRate, habitData];
}

final class AchievedStatisticLoaded extends StatisticCrudState {
  final int achievedHabits;
  final Duration avgDuration;
  final Duration longestDuration;
  final Duration fastestDuration;
  final Map<String, List<double>> habitData;

  const AchievedStatisticLoaded({
    required this.achievedHabits,
    required this.avgDuration,
    required this.longestDuration,
    required this.fastestDuration,
    required this.habitData,
  });

  @override
  List<Object?> get props => [
        achievedHabits,
        avgDuration,
        longestDuration,
        fastestDuration,
        habitData,
      ];
}
