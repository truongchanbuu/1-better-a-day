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
      goalType: json['goalType'] as String,
      currentValue: (json['currentValue'] as num).toDouble(),
      targetValue: (json['targetValue'] as num).toDouble(),
      goalFrequency: (json['goalFrequency'] as num).toInt(),
      goalUnit: json['goalUnit'] as String,
    );

Map<String, dynamic> _$HabitGoalModelToJson(HabitGoalModel instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'habitId': instance.habitId,
      'goalDesc': instance.goalDesc,
      'goalType': instance.goalType,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
      'goalFrequency': instance.goalFrequency,
      'goalUnit': instance.goalUnit,
    };
