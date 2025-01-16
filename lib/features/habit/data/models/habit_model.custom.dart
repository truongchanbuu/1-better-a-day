part of 'habit_model.dart';

HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => HabitModel(
      habitId: json['habitId'] as String,
      habitTitle: json['habitTitle'] as String,
      habitIcon: HabitIcon.fromJson(json['habitIcon']),
      habitDesc: json['habitDesc'] as String,
      habitProgress: (json['habitProgress'] as num).toDouble(),
      habitGoal: HabitGoalModel.fromJson(json['habitGoal']),
      habitCategory: $enumDecode(_$HabitCategoryEnumMap, json['habitCategory']),
      timeOfDay: $enumDecode(_$HabitTimeOfDayEnumMap, json['timeOfDay']),
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reminderTimes: (json['reminderTimes'] is Iterable)
          ? Set<String>.from(json['reminderTimes'])
          : {},
      habitStatus: $enumDecode(_$HabitStatusEnumMap, json['habitStatus']),
      isReminderEnabled: json['isReminderEnabled'] ?? false,
    );

Map<String, dynamic> _$HabitModelToJson(HabitModel instance) {
  return {
    'habitId': instance.habitId,
    'habitTitle': instance.habitTitle,
    'habitIcon': instance.habitIcon.toJson(),
    'habitDesc': instance.habitDesc,
    'habitProgress': instance.habitProgress,
    'habitGoal': HabitGoalModel.fromEntity(instance.habitGoal).toJson(),
    'habitCategory': _$HabitCategoryEnumMap[instance.habitCategory],
    'timeOfDay': _$HabitTimeOfDayEnumMap[instance.timeOfDay],
    'currentStreak': instance.currentStreak,
    'longestStreak': instance.longestStreak,
    'startDate': instance.startDate.toIso8601String(),
    'endDate': instance.endDate.toIso8601String(),
    'reminderTimes': instance.reminderTimes,
    'habitStatus': _$HabitStatusEnumMap[instance.habitStatus],
    'isReminderEnabled': instance.isReminderEnabled,
  };
}

const _$HabitTimeOfDayEnumMap = {
  HabitTimeOfDay.morning: 'morning',
  HabitTimeOfDay.afternoon: 'afternoon',
  HabitTimeOfDay.evening: 'evening',
  HabitTimeOfDay.night: 'night',
  HabitTimeOfDay.anytime: 'anytime'
};

const _$HabitStatusEnumMap = {
  HabitStatus.failed: 'failed',
  HabitStatus.inProgress: 'inProgress',
  HabitStatus.paused: 'paused',
  HabitStatus.skipped: 'skipped',
  HabitStatus.achieved: 'achieved',
  HabitStatus.pending: 'pending',
};

const _$HabitCategoryEnumMap = {
  HabitCategory.health: 'health',
  HabitCategory.education: 'education',
  HabitCategory.productivity: 'productivity',
  HabitCategory.mindfulness: 'mindfulness',
  HabitCategory.lifestyle: 'lifestyle',
  HabitCategory.nutrition: 'nutrition',
  HabitCategory.social: 'social',
  HabitCategory.finance: 'finance',
  HabitCategory.creativity: 'creativity',
  HabitCategory.environmental: 'environmental',
  HabitCategory.custom: 'custom',
};
