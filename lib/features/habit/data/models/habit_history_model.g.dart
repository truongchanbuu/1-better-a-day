// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitHistoryModel _$HabitHistoryModelFromJson(Map<String, dynamic> json) =>
    HabitHistoryModel(
      id: json['id'] as String,
      habitId: json['habitId'] as String,
      date: DateTime.parse(json['date'] as String),
      executionStatus: json['executionStatus'] as String,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      measurement: json['measurement'] as String?,
      mood: json['mood'] as String?,
      customData: json['customData'] as Map<String, dynamic>?,
      note: json['note'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toInt(),
      currentValue: (json['currentValue'] as num?)?.toDouble() ?? 0,
      targetValue: (json['targetValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HabitHistoryModelToJson(HabitHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
      'executionStatus': instance.executionStatus,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration?.inMicroseconds,
      'note': instance.note,
      'rating': instance.rating,
      'mood': instance.mood,
      'quantity': instance.quantity,
      'measurement': instance.measurement,
      'customData': instance.customData,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
    };
