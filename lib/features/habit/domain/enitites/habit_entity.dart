import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final String habitId;
  final String habitTitle;
  final String habitDesc;
  final String habitGoal;
  final Duration duration;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? reminderTime;
  final String habitStatus;
  
  const HabitEntity({
    required this.habitId,
    required this.habitTitle,
    required this.habitDesc,
    required this.habitGoal,
    required this.duration,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    this.reminderTime,
    required this.habitStatus,
  });

  HabitEntity copyWith({
    String? habitId,
    String? habitTitle,
    String? habitDesc,
    String? habitGoal,
    Duration? duration,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? reminderTime,
    String? habitStatus,
  }) {
    return HabitEntity(
      habitId: habitId ?? this.habitId,
      habitTitle: habitTitle ?? this.habitTitle,
      habitDesc: habitDesc ?? this.habitDesc,
      habitGoal: habitGoal ?? this.habitGoal,
      duration: duration ?? this.duration,
      frequency: frequency ?? this.frequency,
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
      habitGoal,
      duration,
      frequency,
      startDate,
      endDate,
      reminderTime,
      habitStatus,
    ];
  }
}
