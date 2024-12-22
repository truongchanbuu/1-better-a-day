import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/enums/habit/goal_unit.dart';

class HabitHistory extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final String executionStatus;
  final String overallStatus;

  final DateTime? startTime;
  final DateTime? endTime;
  final Duration? duration;

  final String? note;
  final int? rating;
  final String? mood;

  final double? quantity;
  final String? measurement;
  final Map<String, dynamic>? customData;

  HabitHistory({
    required this.id,
    required this.habitId,
    required this.date,
    required this.executionStatus,
    required this.overallStatus,
    this.startTime,
    this.endTime,
    this.duration,
    this.note,
    this.rating,
    this.mood,
    this.quantity,
    this.measurement,
    this.customData,
  }) : assert(measurement != GoalUnit.custom.name || customData != null,
            'customData must not be null when measurement is custom');

  HabitHistory copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    DateTime? completedAt,
    bool? isCompleted,
    String? executionStatus,
    String? overallStatus,
    ValueGetter<DateTime?>? startTime,
    ValueGetter<DateTime?>? endTime,
    ValueGetter<Duration?>? duration,
    ValueGetter<String?>? note,
    ValueGetter<int?>? rating,
    ValueGetter<String?>? mood,
    ValueGetter<double?>? quantity,
    ValueGetter<String?>? measurement,
    ValueGetter<Map<String, dynamic>?>? customData,
  }) {
    return HabitHistory(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      executionStatus: executionStatus ?? this.executionStatus,
      overallStatus: overallStatus ?? this.overallStatus,
      startTime: startTime != null ? startTime() : this.startTime,
      endTime: endTime != null ? endTime() : this.endTime,
      duration: duration != null ? duration() : this.duration,
      note: note != null ? note() : this.note,
      rating: rating != null ? rating() : this.rating,
      mood: mood != null ? mood() : this.mood,
      quantity: quantity != null ? quantity() : this.quantity,
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
      overallStatus,
      startTime,
      endTime,
      duration,
      note,
      rating,
      mood,
      quantity,
      measurement,
      customData,
    ];
  }
}
