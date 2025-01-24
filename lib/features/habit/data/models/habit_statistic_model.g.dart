// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitStatisticModel _$HabitStatisticModelFromJson(Map<String, dynamic> json) =>
    HabitStatisticModel(
      achievedHabits: (json['achievedHabits'] as num?)?.toInt() ?? 0,
      achievementsCompleted:
          (json['achievementsCompleted'] as num?)?.toInt() ?? 0,
      activeHabits: (json['activeHabits'] as num?)?.toInt() ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      completionRateChange:
          (json['completionRateChange'] as num?)?.toInt() ?? 0,
      failedHabits: (json['failedHabits'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      pausedHabits: (json['pausedHabits'] as num?)?.toInt() ?? 0,
      totalHabits: (json['totalHabits'] as num?)?.toInt() ?? 0,
      trendPercentage: (json['trendPercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$HabitStatisticModelToJson(
        HabitStatisticModel instance) =>
    <String, dynamic>{
      'totalHabits': instance.totalHabits,
      'activeHabits': instance.activeHabits,
      'pausedHabits': instance.pausedHabits,
      'failedHabits': instance.failedHabits,
      'achievedHabits': instance.achievedHabits,
      'completionRate': instance.completionRate,
      'completionRateChange': instance.completionRateChange,
      'longestStreak': instance.longestStreak,
      'trendPercentage': instance.trendPercentage,
      'achievementsCompleted': instance.achievementsCompleted,
    };
