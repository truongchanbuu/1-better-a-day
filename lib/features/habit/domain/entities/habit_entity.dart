import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import 'habit_icon.dart';
import '../../../../generated/l10n.dart';
import 'habit_goal.dart';

class HabitEntity extends Equatable {
  final String habitId;
  final String habitTitle;
  final HabitIcon habitIcon;
  final String habitDesc;
  final double habitProgress;
  final HabitGoal habitGoal;
  final HabitCategory habitCategory;
  final HabitTimeOfDay timeOfDay;
  final int currentStreak;
  final int longestStreak;
  final DateTime startDate;
  final DateTime endDate;
  final HabitStatus habitStatus;
  final Set<String> reminderTimes;
  final bool isReminderEnabled;
  final Map<String, bool> reminderStates;

  HabitEntity({
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
    required this.habitIcon,
    this.reminderTimes = const {},
    this.habitProgress = 0,
    this.isReminderEnabled = false,
    Map<String, bool>? reminderStates,
  }) : reminderStates =
            reminderStates ?? {for (var time in reminderTimes) time: true};

  HabitEntity copyWith({
    String? habitId,
    String? habitTitle,
    HabitIcon? habitIcon,
    String? habitDesc,
    HabitGoal? habitGoal,
    HabitCategory? habitCategory,
    double? habitProgress,
    HabitTimeOfDay? timeOfDay,
    int? currentStreak,
    int? longestStreak,
    DateTime? startDate,
    DateTime? endDate,
    Set<String>? reminderTimes,
    HabitStatus? habitStatus,
    bool? isReminderEnabled,
    Map<String, bool>? reminderStates,
  }) {
    return HabitEntity(
      habitId: habitId ?? this.habitId,
      habitTitle: habitTitle ?? this.habitTitle,
      habitIcon: habitIcon ?? this.habitIcon,
      habitDesc: habitDesc ?? this.habitDesc,
      habitGoal: habitGoal ?? this.habitGoal,
      habitCategory: habitCategory ?? this.habitCategory,
      habitProgress: habitProgress ?? this.habitProgress,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      habitStatus: habitStatus ?? this.habitStatus,
      isReminderEnabled: isReminderEnabled ?? this.isReminderEnabled,
      reminderStates: reminderStates ?? this.reminderStates,
    );
  }

  @override
  List<Object?> get props {
    return [
      habitId,
      habitTitle,
      habitDesc,
      habitIcon,
      habitGoal,
      habitCategory,
      habitProgress,
      currentStreak,
      longestStreak,
      timeOfDay,
      startDate,
      endDate,
      DeepCollectionEquality().hash(reminderTimes),
      DeepCollectionEquality().hash(reminderStates),
      habitStatus,
      isReminderEnabled,
    ];
  }

  String get getStreakMessage {
    if (longestStreak <= 7) {
      switch (longestStreak) {
        case 0:
          return S.current.streak_short_0;
        case 1:
          return S.current.streak_short_1;
        case 3:
          return S.current.streak_short_3;
        case 7:
          return S.current.streak_short_7;
        default:
          return S.current.default_short_streak(longestStreak);
      }
    } else if (longestStreak <= 30) {
      if (longestStreak == 10) {
        return S.current.streak_medium_10;
      } else if (longestStreak == 15) {
        return S.current.streak_medium_15;
      } else if (longestStreak == 30) {
        return S.current.streak_medium_30;
      } else {
        return S.current.default_medium_streak(longestStreak);
      }
    } else if (longestStreak <= 100) {
      if (longestStreak == 40) {
        return S.current.streak_long_40;
      } else if (longestStreak == 60) {
        return S.current.streak_long_60;
      } else if (longestStreak == 100) {
        return S.current.streak_long_100;
      } else {
        return S.current.default_long_streak(longestStreak);
      }
    } else {
      if (longestStreak == 150) {
        return S.current.streak_very_long_150;
      } else if (longestStreak == 200) {
        return S.current.streak_very_long_200;
      } else if (longestStreak == 365) {
        return S.current.streak_very_long_365;
      } else {
        return S.current.default_long_streak(longestStreak);
      }
    }
  }

  Duration get duration => endDate.difference(startDate);
}
