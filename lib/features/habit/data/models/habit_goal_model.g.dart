// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitGoalModel _$HabitGoalModelFromJson(Map<String, dynamic> json) =>
    HabitGoalModel(
      goalId: json['goalId'] as String,
      habitId: json['habitId'] as String,
      goalDesc: json['goalDesc'] as String,
      goalType: $enumDecode(_$GoalTypeEnumMap, json['goalType']),
      targetValue: (json['targetValue'] as num).toDouble(),
      goalFreq: HabitGoalModel._goalFrequencyFromJson(json['goalFrequency']),
      goalUnit: $enumDecode(_$GoalUnitEnumMap, json['goalUnit']),
    );

Map<String, dynamic> _$HabitGoalModelToJson(HabitGoalModel instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'habitId': instance.habitId,
      'goalDesc': instance.goalDesc,
      'goalType': _$GoalTypeEnumMap[instance.goalType]!,
      'targetValue': instance.targetValue,
      'goalUnit': _$GoalUnitEnumMap[instance.goalUnit]!,
      'goalFrequency': instance.goalFreq.toJson(),
    };

const _$GoalTypeEnumMap = {
  GoalType.completion: 'completion',
  GoalType.count: 'count',
  GoalType.distance: 'distance',
  GoalType.duration: 'duration',
  GoalType.custom: 'custom',
};

const _$GoalUnitEnumMap = {
  GoalUnit.reps: 'reps',
  GoalUnit.sets: 'sets',
  GoalUnit.l: 'l',
  GoalUnit.ml: 'ml',
  GoalUnit.day: 'day',
  GoalUnit.second: 'second',
  GoalUnit.minutes: 'minutes',
  GoalUnit.hour: 'hour',
  GoalUnit.page: 'page',
  GoalUnit.cm: 'cm',
  GoalUnit.km: 'km',
  GoalUnit.m: 'm',
  GoalUnit.steps: 'steps',
  GoalUnit.miles: 'miles',
  GoalUnit.times: 'times',
  GoalUnit.custom: 'custom',
};
