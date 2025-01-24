import 'package:equatable/equatable.dart';

class HabitStatisticEntity extends Equatable {
  final int totalHabits;
  final int activeHabits;
  final int pausedHabits;
  final int failedHabits;
  final int achievedHabits;
  final double completionRate;
  final int completionRateChange;
  final int longestStreak;
  final double trendPercentage;
  final int achievementsCompleted;

  const HabitStatisticEntity({
    this.totalHabits = 0,
    this.activeHabits = 0,
    this.pausedHabits = 0,
    this.failedHabits = 0,
    this.achievedHabits = 0,
    this.completionRate = 0.0,
    this.completionRateChange = 0,
    this.longestStreak = 0,
    this.trendPercentage = 0.0,
    this.achievementsCompleted = 0,
  });

  HabitStatisticEntity copyWith({
    int? totalHabits,
    int? activeHabits,
    int? pausedHabits,
    int? failedHabits,
    int? achievedHabits,
    double? completionRate,
    int? completionRateChange,
    int? longestStreak,
    double? trendPercentage,
    int? achievementsCompleted,
  }) {
    return HabitStatisticEntity(
      totalHabits: totalHabits ?? this.totalHabits,
      activeHabits: activeHabits ?? this.activeHabits,
      pausedHabits: pausedHabits ?? this.pausedHabits,
      failedHabits: failedHabits ?? this.failedHabits,
      achievedHabits: achievedHabits ?? this.achievedHabits,
      completionRate: completionRate ?? this.completionRate,
      completionRateChange: completionRateChange ?? this.completionRateChange,
      longestStreak: longestStreak ?? this.longestStreak,
      trendPercentage: trendPercentage ?? this.trendPercentage,
      achievementsCompleted:
          achievementsCompleted ?? this.achievementsCompleted,
    );
  }

  @override
  List<Object?> get props {
    return [
      totalHabits,
      activeHabits,
      pausedHabits,
      failedHabits,
      achievedHabits,
      completionRate,
      completionRateChange,
      longestStreak,
      trendPercentage,
      achievementsCompleted,
    ];
  }
}
