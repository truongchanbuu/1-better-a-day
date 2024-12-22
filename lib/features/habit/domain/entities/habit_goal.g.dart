// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitGoal _$HabitGoalFromJson(Map<String, dynamic> json) => HabitGoal(
      goalId: json['goalId'] as String,
      habitId: json['habitId'] as String,
      goalDesc: json['goalDesc'] as String,
      goalType: json['goalType'] as String,
      currentValue: (json['currentValue'] as num?)?.toDouble() ?? 0,
      targetValue: (json['targetValue'] as num).toDouble(),
      goalUnit: json['goalUnit'] as String,
      goalFrequency: (json['goalFrequency'] as num).toInt(),
    );

Map<String, dynamic> _$HabitGoalToJson(HabitGoal instance) => <String, dynamic>{
      'goalId': instance.goalId,
      'habitId': instance.habitId,
      'goalDesc': instance.goalDesc,
      'goalType': instance.goalType,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
      'goalFrequency': instance.goalFrequency,
      'goalUnit': instance.goalUnit,
    };
