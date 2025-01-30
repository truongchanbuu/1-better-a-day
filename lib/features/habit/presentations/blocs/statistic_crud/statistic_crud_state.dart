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
  final double completionRate;
  final double completionRateTrend;
  final List<HabitHistory> allHistories;

  const GeneralStatisticLoaded({
    required this.totalHabits,
    required this.activeHabits,
    required this.pausedHabits,
    required this.failedHabits,
    required this.achievedHabits,
    required this.longestStreak,
    required this.totalAchievements,
    required this.completionRate,
    required this.completionRateTrend,
    required this.allHistories,
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
        completionRate,
        completionRateTrend,
        allHistories,
      ];
}
