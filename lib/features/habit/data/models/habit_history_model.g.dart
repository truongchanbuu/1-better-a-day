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
      executionStatus: $enumDecode(_$DayStatusEnumMap, json['executionStatus']),
      measurement: $enumDecode(_$GoalUnitEnumMap, json['measurement']),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      mood: $enumDecodeNullable(_$MoodEnumMap, json['mood']),
      note: json['note'] as String?,
      targetValue: (json['targetValue'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$HabitHistoryModelToJson(HabitHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
      'executionStatus': _$DayStatusEnumMap[instance.executionStatus]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration?.inMicroseconds,
      'note': instance.note,
      'rating': instance.rating,
      'mood': _$MoodEnumMap[instance.mood],
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'measurement': _$GoalUnitEnumMap[instance.measurement]!,
    };

const _$DayStatusEnumMap = {
  DayStatus.completed: 'completed',
  DayStatus.failed: 'failed',
  DayStatus.skipped: 'skipped',
  DayStatus.inProgress: 'inProgress',
};

const _$GoalUnitEnumMap = {
  GoalUnit.reps: 'reps',
  GoalUnit.sets: 'sets',
  GoalUnit.l: 'l',
  GoalUnit.ml: 'ml',
  GoalUnit.day: 'day',
  GoalUnit.second: 'second',
  GoalUnit.minute: 'minute',
  GoalUnit.hour: 'hour',
  GoalUnit.page: 'page',
  GoalUnit.cm: 'cm',
  GoalUnit.km: 'km',
  GoalUnit.m: 'm',
  GoalUnit.steps: 'steps',
  GoalUnit.miles: 'miles',
  GoalUnit.times: 'times',
  GoalUnit.glasses: 'glasses',
  GoalUnit.custom: 'custom',
};

const _$MoodEnumMap = {
  Mood.great: 'great',
  Mood.good: 'good',
  Mood.neutral: 'neutral',
  Mood.bad: 'bad',
  Mood.terrible: 'terrible',
};
