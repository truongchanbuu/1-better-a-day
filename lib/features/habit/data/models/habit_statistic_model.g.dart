// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitStatisticModel _$HabitStatisticModelFromJson(Map<String, dynamic> json) =>
    HabitStatisticModel(
      habitId: json['habitId'] as String,
      totalTrackedDays: (json['totalTrackedDays'] as num).toInt(),
      totalCompletions: (json['totalCompletions'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      mostCommonMood: json['mostCommonMood'] as String,
      longestStreak: (json['longestStreak'] as num).toInt(),
      totalDuration:
          Duration(microseconds: (json['totalDuration'] as num).toInt()),
    );

Map<String, dynamic> _$HabitStatisticModelToJson(
        HabitStatisticModel instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'totalTrackedDays': instance.totalTrackedDays,
      'totalCompletions': instance.totalCompletions,
      'averageRating': instance.averageRating,
      'mostCommonMood': instance.mostCommonMood,
      'longestStreak': instance.longestStreak,
      'totalDuration': instance.totalDuration.inMicroseconds,
    };
