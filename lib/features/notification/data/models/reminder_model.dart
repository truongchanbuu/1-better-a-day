import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/reminder/reminder_status.dart';
import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/reminder_entity.dart';

part 'reminder_model.g.dart';

@JsonSerializable()
class ReminderModel extends ReminderEntity implements HiveBaseModel {
  const ReminderModel({
    required super.reminderId,
    required super.reminderTitle,
    required super.habitId,
    required super.reminderTime,
    required super.reminderStatus,
    super.frequency,
  });

  factory ReminderModel.fromEntity(ReminderEntity entity) {
    return ReminderModel(
      reminderId: entity.reminderId,
      reminderTitle: entity.reminderTitle,
      habitId: entity.habitId,
      reminderTime: entity.reminderTime,
      reminderStatus: entity.reminderStatus,
      frequency: entity.frequency,
    );
  }

  ReminderEntity toEntity() {
    return ReminderEntity(
      reminderId: reminderId,
      reminderTitle: reminderTitle,
      habitId: habitId,
      frequency: frequency,
      reminderTime: reminderTime,
      reminderStatus: reminderStatus,
    );
  }

  @override
  ReminderModel copyWith({
    String? reminderId,
    String? reminderTitle,
    String? habitId,
    DateTime? reminderTime,
    ValueGetter<String?>? frequency,
    ReminderStatus? reminderStatus,
  }) {
    return ReminderModel(
      reminderId: reminderId ?? this.reminderId,
      reminderTitle: reminderTitle ?? this.reminderTitle,
      habitId: habitId ?? this.habitId,
      reminderTime: reminderTime ?? this.reminderTime,
      frequency: frequency?.call() ?? this.frequency,
      reminderStatus: reminderStatus ?? this.reminderStatus,
    );
  }

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);

  @override
  fromMap(Map<String, dynamic> map) {
    return ReminderModel.fromJson(map);
  }

  @override
  get key => reminderId;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
