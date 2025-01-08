// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_frequency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitFrequency _$HabitFrequencyFromJson(Map<String, dynamic> json) =>
    HabitFrequency(
      type: $enumDecode(_$FrequencyTypeEnumMap, json['type']),
      interval: HabitFrequency.timeIntervalFromJson(json['interval']),
      monthlyDates: (json['monthlyDates'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toSet(),
      weekDays: (json['weekDays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toSet(),
      lastCompletionTime: json['lastCompletionTime'] == null
          ? null
          : DateTime.parse(json['lastCompletionTime'] as String),
    );

Map<String, dynamic> _$HabitFrequencyToJson(HabitFrequency instance) =>
    <String, dynamic>{
      'type': _$FrequencyTypeEnumMap[instance.type]!,
      'interval': instance.interval?.toJson(),
      'monthlyDates': instance.monthlyDates?.toList(),
      'weekDays': instance.weekDays?.toList(),
      'lastCompletionTime': instance.lastCompletionTime?.toIso8601String(),
    };

const _$FrequencyTypeEnumMap = {
  FrequencyType.interval: 'interval',
  FrequencyType.daily: 'daily',
  FrequencyType.weekDays: 'weekDays',
  FrequencyType.monthly: 'monthly',
};
