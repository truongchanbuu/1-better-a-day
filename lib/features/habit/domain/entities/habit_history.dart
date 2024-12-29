import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_unit.dart';

class HabitHistory extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final String executionStatus;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration? duration;
  final String? note;
  final int? rating;
  final String? mood;
  final double? quantity;
  final double currentValue;
  final String? measurement;
  final Map<String, dynamic>? customData;

  HabitHistory({
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
    this.quantity,
    this.currentValue = 0,
    this.measurement,
    this.customData,
  }) : assert(measurement != GoalUnit.custom.name || customData != null,
            'customData must not be null when measurement is custom');

  factory HabitHistory.init() {
    return HabitHistory(
      id: const Uuid().v4(),
      habitId: '',
      date: DateTime.now(),
      currentValue: 0,
      executionStatus: DayStatus.inProgress.name,
      startTime: null,
      endTime: null,
      duration: null,
      note: null,
      rating: null,
      mood: null,
      quantity: null,
      measurement: null,
      customData: null,
    );
  }

  HabitHistory copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    DateTime? completedAt,
    bool? isCompleted,
    String? executionStatus,
    double? currentValue,
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
      currentValue: currentValue ?? this.currentValue,
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
      startTime,
      endTime,
      duration,
      currentValue,
      note,
      rating,
      mood,
      quantity,
      measurement,
      customData,
    ];
  }
}
