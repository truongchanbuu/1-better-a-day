import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'habit_goal.dart';

@JsonSerializable()
class HabitEntity extends Equatable {
  final String habitId;
  final String habitTitle;
  final String? iconName;
  final String habitDesc;
  final double habitProgress;
  final HabitGoal habitGoal;
  final String habitCategory;
  final String timeOfDay;
  final int currentStreak;
  final int longestStreak;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? reminderTime;
  final String habitStatus;

  const HabitEntity({
    required this.habitId,
    required this.habitTitle,
    required this.habitDesc,
    required this.habitGoal,
    required this.habitCategory,
    required this.timeOfDay,
    required this.endDate,
    required this.habitStatus,
    required this.startDate,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.iconName,
    this.reminderTime,
    this.habitProgress = 0,
  });

  HabitEntity copyWith({
    String? habitId,
    String? habitTitle,
    String? iconName,
    String? habitDesc,
    HabitGoal? habitGoal,
    String? habitCategory,
    double? habitProgress,
    String? timeOfDay,
    int? currentStreak,
    int? longestStreak,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? reminderTime,
    String? habitStatus,
  }) {
    return HabitEntity(
      habitId: habitId ?? this.habitId,
      habitTitle: habitTitle ?? this.habitTitle,
      iconName: iconName ?? this.iconName,
      habitDesc: habitDesc ?? this.habitDesc,
      habitGoal: habitGoal ?? this.habitGoal,
      habitCategory: habitCategory ?? this.habitCategory,
      habitProgress: habitProgress ?? this.habitProgress,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTime: reminderTime ?? this.reminderTime,
      habitStatus: habitStatus ?? this.habitStatus,
    );
  }

  @override
  List<Object?> get props {
    return [
      habitId,
      habitTitle,
      habitDesc,
      iconName,
      habitGoal,
      habitCategory,
      habitProgress,
      currentStreak,
      longestStreak,
      timeOfDay,
      startDate,
      endDate,
      reminderTime,
      habitStatus,
    ];
  }
}
