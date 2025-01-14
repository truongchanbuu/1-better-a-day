import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/mood.dart';

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
  final GoalUnit? measurement;
  final Map<String, dynamic>? customData;

  const HabitHistory({
    required this.id,
    required this.habitId,
    required this.date,
    required this.executionStatus,
    this.startTime,
    this.endTime,
    this.duration,
    this.note,
    this.rating,
    this.mood,
    this.targetValue,
    this.currentValue = 0,
    this.measurement,
    this.customData,
  }) : assert(measurement != GoalUnit.custom || customData != null,
            'customData must not be null when measurement is custom');

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
      measurement: null,
      customData: null,
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
    ValueGetter<GoalUnit?>? measurement,
    ValueGetter<Map<String, dynamic>?>? customData,
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
      customData: customData != null ? customData() : this.customData,
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
      customData,
    ];
  }
}
