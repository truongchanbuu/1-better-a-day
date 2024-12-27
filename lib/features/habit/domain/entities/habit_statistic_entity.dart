import 'dart:convert';

import 'package:equatable/equatable.dart';

class HabitStatisticEntity extends Equatable {
  final String habitId;
  final int totalTrackedDays;
  final int totalCompletions;
  final double averageRating;
  final String mostCommonMood;
  final int longestStreak;
  final Duration totalDuration;

  const HabitStatisticEntity({
    required this.habitId,
    required this.totalTrackedDays,
    required this.totalCompletions,
    required this.averageRating,
    required this.mostCommonMood,
    required this.longestStreak,
    required this.totalDuration,
  });

  HabitStatisticEntity copyWith({
    String? habitId,
    int? totalTrackedDays,
    int? totalCompletions,
    double? averageRating,
    String? mostCommonMood,
    int? longestStreak,
    Duration? totalDuration,
  }) {
    return HabitStatisticEntity(
      habitId: habitId ?? this.habitId,
      totalTrackedDays: totalTrackedDays ?? this.totalTrackedDays,
      totalCompletions: totalCompletions ?? this.totalCompletions,
      averageRating: averageRating ?? this.averageRating,
      mostCommonMood: mostCommonMood ?? this.mostCommonMood,
      longestStreak: longestStreak ?? this.longestStreak,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }

  @override
  List<Object?> get props {
    return [
      habitId,
      totalTrackedDays,
      totalCompletions,
      averageRating,
      mostCommonMood,
      longestStreak,
      totalDuration,
    ];
  }
}
