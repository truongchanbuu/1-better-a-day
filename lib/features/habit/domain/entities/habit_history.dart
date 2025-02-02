import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/mood.dart';
import 'habit_entity.dart';

class HabitHistory extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final DayStatus executionStatus;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration? duration;
  final String? note;
  final double? rating;
  final Mood? mood;
  final double? targetValue;
  final double currentValue;
  final GoalUnit measurement;

  const HabitHistory({
    required this.id,
    required this.habitId,
    required this.date,
    required this.executionStatus,
    required this.measurement,
    this.startTime,
    this.endTime,
    this.duration,
    this.note,
    this.rating,
    this.mood,
    this.targetValue,
    this.currentValue = 0,
  });

  factory HabitHistory.init() {
    return HabitHistory(
      id: '',
      habitId: '',
      date: DateTime.now(),
      executionStatus: DayStatus.inProgress,
      startTime: null,
      endTime: null,
      duration: null,
      note: null,
      rating: null,
      mood: null,
      targetValue: null,
      measurement: GoalUnit.custom,
    );
  }

  factory HabitHistory.failedHistory({
    required String habitId,
    required DateTime date,
    required GoalUnit measurement,
    double? targetValue,
  }) {
    return HabitHistory(
      id: Uuid().v4(),
      habitId: habitId,
      date: date,
      executionStatus: DayStatus.failed,
      measurement: measurement,
      targetValue: targetValue,
      currentValue: 0,
    );
  }

  HabitHistory copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    DayStatus? executionStatus,
    double? currentValue,
    ValueGetter<DateTime?>? startTime,
    ValueGetter<DateTime?>? endTime,
    ValueGetter<Duration?>? duration,
    ValueGetter<String?>? note,
    ValueGetter<double?>? rating,
    ValueGetter<Mood?>? mood,
    ValueGetter<double?>? targetValue,
    ValueGetter<GoalUnit>? measurement,
  }) {
    return HabitHistory(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      executionStatus: executionStatus ?? this.executionStatus,
      currentValue: currentValue ?? this.currentValue,
      startTime: startTime != null ? startTime() : this.startTime,
      endTime: endTime != null ? endTime() : this.endTime,
      duration: duration != null ? duration() : this.duration,
      note: note != null ? note() : this.note,
      rating: rating != null ? rating() : this.rating,
      mood: mood != null ? mood() : this.mood,
      targetValue: targetValue != null ? targetValue() : this.targetValue,
      measurement: measurement != null ? measurement() : this.measurement,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      habitId,
      date,
      executionStatus,
      startTime,
      endTime,
      duration,
      currentValue,
      note,
      rating,
      mood,
      targetValue,
      measurement,
    ];
  }

  static HabitEntity updateStreakIfNeeded({
    required HabitEntity habit,
    required List<HabitHistory> histories,
  }) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    final normalizedYesterday = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
    );

    final yesterdayHistory = histories.where((history) {
      final historyDate = DateTime(
        history.date.year,
        history.date.month,
        history.date.day,
      );
      return historyDate.isAtSameMomentAs(normalizedYesterday);
    }).firstOrNull;

    if (yesterdayHistory == null ||
        yesterdayHistory.executionStatus != DayStatus.completed) {
      return habit.copyWith(
        currentStreak: 0,
        longestStreak: habit.longestStreak > habit.currentStreak
            ? habit.longestStreak
            : habit.currentStreak,
      );
    }

    return habit;
  }

  static List<HabitEntity> batchUpdateStreaks({
    required List<HabitEntity> habits,
    required Map<String, List<HabitHistory>> historiesMap,
  }) {
    return habits.map((habit) {
      final habitHistories = historiesMap[habit.habitId] ?? [];
      return updateStreakIfNeeded(
        habit: habit,
        histories: habitHistories,
      );
    }).toList();
  }

  static HabitEntity incrementStreak(HabitEntity habit) {
    final newStreak = habit.currentStreak + 1;
    return habit.copyWith(
      currentStreak: newStreak,
      longestStreak:
          newStreak > habit.longestStreak ? newStreak : habit.longestStreak,
    );
  }

  static List<HabitHistory> fillMissingHistoryRecords({
    required String habitId,
    required DateTime startDate,
    required DateTime endDate,
    required Set<DateTime> existingDates,
    required GoalUnit measurement,
    double? targetValue,
  }) {
    final List<HabitHistory> generatedHistories = [];

    final normalizedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    final normalizedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day);

    for (var date = normalizedStartDate;
        date.isBefore(normalizedEndDate) ||
            date.isAtSameMomentAs(normalizedEndDate);
        date = date.add(const Duration(days: 1))) {
      // Check if we already have a history record for this date
      bool hasExistingRecord = existingDates.contains(DateTime(
        date.year,
        date.month,
        date.day,
      ));

      if (!hasExistingRecord) {
        generatedHistories.add(
          HabitHistory.failedHistory(
            habitId: habitId,
            date: date,
            measurement: measurement,
            targetValue: targetValue,
          ),
        );
      }
    }

    return generatedHistories;
  }
}
