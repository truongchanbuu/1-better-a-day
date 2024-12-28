import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/habit_history.dart';

part 'habit_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitHistoryModel extends HabitHistory implements HiveBaseModel {
  HabitHistoryModel({
    required super.id,
    required super.habitId,
    required super.date,
    required super.executionStatus,
    super.startTime,
    super.endTime,
    super.duration,
    super.measurement,
    super.mood,
    super.customData,
    super.note,
    super.quantity,
    super.rating,
    super.currentValue,
    super.targetValue,
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
      customData: customData,
      note: note,
      quantity: quantity,
      rating: rating,
      currentValue: currentValue,
      targetValue: targetValue,
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
      customData: entity.customData,
      note: entity.note,
      quantity: entity.quantity,
      rating: entity.rating,
      currentValue: entity.currentValue,
      targetValue: entity.targetValue,
    );
  }

  /// Returns a new instance with updated properties.
  @override
  HabitHistory copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    DateTime? completedAt,
    bool? isCompleted,
    String? executionStatus,
    String? overallStatus,
    double? currentValue,
    double? targetValue,
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
    return HabitHistoryModel(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      executionStatus: executionStatus ?? this.executionStatus,
      startTime: startTime?.call() ?? this.startTime,
      endTime: endTime?.call() ?? this.endTime,
      duration: duration?.call() ?? this.duration,
      measurement: measurement?.call() ?? this.measurement,
      mood: mood?.call() ?? this.mood,
      customData: customData?.call() ?? this.customData,
      note: note?.call() ?? this.note,
      quantity: quantity?.call() ?? this.quantity,
      rating: rating?.call() ?? this.rating,
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
