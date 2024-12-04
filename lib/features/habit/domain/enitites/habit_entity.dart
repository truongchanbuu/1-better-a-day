import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final String habitId;
  final String habitTitle;
  final String? iconName;
  final String? customIconUrl;
  final String habitDesc;
  final double habitProgress;
  final String habitGoal;
  final String habitCategory;
  final String timeOfDay;
  final Duration duration;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? reminderTime;
  final String habitStatus;

  const HabitEntity({
    required this.habitId,
    required this.habitTitle,
    this.iconName,
    required this.habitDesc,
    required this.habitGoal,
    required this.habitCategory,
    required this.timeOfDay,
    required this.duration,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    this.reminderTime,
    this.customIconUrl,
    required this.habitStatus,
    this.habitProgress = 0,
  });

  HabitEntity copyWith({
    String? habitId,
    String? habitTitle,
    String? iconName,
    String? habitDesc,
    String? habitGoal,
    String? habitCategory,
    double? habitProgress,
    String? timeOfDay,
    Duration? duration,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? reminderTime,
    String? customIconUrl,
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
      timeOfDay: timeOfDay ?? this.timeOfDay,
      duration: duration ?? this.duration,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTime: reminderTime ?? this.reminderTime,
      habitStatus: habitStatus ?? this.habitStatus,
      customIconUrl: customIconUrl ?? this.customIconUrl,
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
      timeOfDay,
      duration,
      frequency,
      startDate,
      endDate,
      reminderTime,
      habitStatus,
      customIconUrl,
    ];
  }
}
