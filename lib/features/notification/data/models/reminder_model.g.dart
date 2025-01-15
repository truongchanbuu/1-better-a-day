// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      reminderId: json['reminderId'] as String,
      reminderTitle: json['reminderTitle'] as String,
      habitId: json['habitId'] as String,
      reminderTime: DateTime.parse(json['reminderTime'] as String),
      reminderStatus:
          $enumDecode(_$ReminderStatusEnumMap, json['reminderStatus']),
      frequency: json['frequency'] == null
          ? null
          : HabitFrequency.fromJson(json['frequency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'reminderId': instance.reminderId,
      'habitId': instance.habitId,
      'reminderTitle': instance.reminderTitle,
      'reminderTime': instance.reminderTime.toIso8601String(),
      'frequency': instance.frequency?.toJson(),
      'reminderStatus': _$ReminderStatusEnumMap[instance.reminderStatus]!,
    };

const _$ReminderStatusEnumMap = {
  ReminderStatus.active: 'active',
  ReminderStatus.skipped: 'skipped',
  ReminderStatus.canceled: 'canceled',
  ReminderStatus.completed: 'completed',
};
