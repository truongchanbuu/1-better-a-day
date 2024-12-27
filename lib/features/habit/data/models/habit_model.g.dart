// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => HabitModel(
      habitId: json['habitId'] as String,
      habitTitle: json['habitTitle'] as String,
      iconName: json['iconName'] as String?,
      habitDesc: json['habitDesc'] as String,
      habitProgress: (json['habitProgress'] as num).toDouble(),
      habitGoal:
          HabitGoalModel.fromJson(json['habitGoal'] as Map<String, dynamic>),
      habitCategory: json['habitCategory'] as String,
      timeOfDay: json['timeOfDay'] as String,
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reminderTime: json['reminderTime'] as String?,
      habitStatus: json['habitStatus'] as String,
    );

/// USE HABIT GOAL MODEL NOT HABIT GOAL
Map<String, dynamic> _$HabitModelToJson(HabitModel instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'habitTitle': instance.habitTitle,
      'iconName': instance.iconName,
      'habitDesc': instance.habitDesc,
      'habitProgress': instance.habitProgress,
      'habitGoal': HabitGoalModel.fromEntity(instance.habitGoal).toJson(),
      'habitCategory': instance.habitCategory,
      'timeOfDay': instance.timeOfDay,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'reminderTime': instance.reminderTime,
      'habitStatus': instance.habitStatus,
    };
