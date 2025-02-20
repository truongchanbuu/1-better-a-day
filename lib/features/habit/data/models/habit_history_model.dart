import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/mood.dart';
import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/habit_history.dart';

part 'habit_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitHistoryModel extends HabitHistory implements HiveBaseModel {
  const HabitHistoryModel({
    required super.id,
    required super.habitId,
    required super.date,
    required super.executionStatus,
    required super.measurement,
    super.startTime,
    super.endTime,
    super.duration,
    super.mood,
    super.note,
    super.targetValue,
    super.rating,
    super.currentValue,
    super.remoteUpdatedAt,
  });

  /// Factory method to create an instance from JSON.
  factory HabitHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HabitHistoryModelFromJson(json);

  /// Converts the instance to JSON.
  Map<String, dynamic> toJson() => _$HabitHistoryModelToJson(this);

  /// Converts the model to its entity counterpart.
  HabitHistory toEntity() {
    return HabitHistory(
      id: id,
      habitId: habitId,
      date: date,
      executionStatus: executionStatus,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      measurement: measurement,
      mood: mood,
      note: note,
      targetValue: targetValue,
      rating: rating,
      currentValue: currentValue,
      remoteUpdatedAt: remoteUpdatedAt,
    );
  }

  /// Creates a model instance from its entity counterpart.
  factory HabitHistoryModel.fromEntity(HabitHistory entity) {
    return HabitHistoryModel(
      id: entity.id,
      habitId: entity.habitId,
      date: entity.date,
      executionStatus: entity.executionStatus,
      startTime: entity.startTime,
      endTime: entity.endTime,
      duration: entity.duration,
      measurement: entity.measurement,
      mood: entity.mood,
      note: entity.note,
      targetValue: entity.targetValue,
      rating: entity.rating,
      currentValue: entity.currentValue,
      remoteUpdatedAt: entity.remoteUpdatedAt,
    );
  }

  /// Returns a new instance with updated properties.
  @override
  HabitHistoryModel copyWith({
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
    DateTime? remoteUpdatedAt,
  }) {
    return HabitHistoryModel(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      currentValue: currentValue ?? this.currentValue,
      executionStatus: executionStatus ?? this.executionStatus,
      startTime: startTime?.call() ?? this.startTime,
      endTime: endTime?.call() ?? this.endTime,
      duration: duration?.call() ?? this.duration,
      measurement: measurement?.call() ?? this.measurement,
      mood: mood?.call() ?? this.mood,
      note: note?.call() ?? this.note,
      targetValue: targetValue?.call() ?? this.targetValue,
      rating: rating?.call() ?? this.rating,
      remoteUpdatedAt: remoteUpdatedAt ?? this.remoteUpdatedAt,
    );
  }

  @override
  HabitHistoryModel fromMap(Map<String, dynamic> map) {
    return HabitHistoryModel.fromJson(map);
  }

  @override
  get key => id;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
