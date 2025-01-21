part of 'achievement_model.dart';

Map<String, dynamic> _$AchievementModelToJson(AchievementModel instance) {
  return {
    'achievementId': instance.achievementId,
    'achievementName': instance.achievementName,
    'achievementDesc': instance.achievementDesc,
    'achievementType': instance.achievementType.name,
    'achievementRequirement': instance.achievementRequirement.toJson(),
    'isUnlocked': instance.isUnlocked,
    'achievementIcon': instance.achievementIcon.toJson(),
    'achievementLevel': instance.achievementLevel.name,
    'unlockedDate': instance.unlockedDate?.toIso8601String(),
    'userEmail': instance.userEmail,
    'username': instance.username,
  };
}

AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) {
  final achievementType = AchievementType.fromString(json['achievementType']);
  AchievementRequirement requirement;
  final jsonRequirement = json['achievementRequirement'];
  if (jsonRequirement is Map) {
    json['achievementRequirement'] = Map<String, dynamic>.from(jsonRequirement);
  } else {
    throw FormatException('Unexpected requirement format');
  }

  if (achievementType == AchievementType.accumulation) {
    requirement =
        AccumulationRequirement.fromJson(json['achievementRequirement']);
  } else if (achievementType == AchievementType.time) {
    requirement = TimeRequirement.fromJson(json['achievementRequirement']);
  } else if (achievementType == AchievementType.streak) {
    requirement = StreakRequirement.fromJson(json['achievementRequirement']);
  } else {
    throw FormatException('Unknown achievement type');
  }

  return AchievementModel(
    achievementId: json['achievementId'],
    achievementName: json['achievementName'],
    achievementDesc: json['achievementDesc'],
    achievementType: achievementType,
    achievementRequirement: requirement,
    isUnlocked: json['isUnlocked'],
    achievementIcon: HabitIcon.fromJson(json['achievementIcon']),
    achievementLevel:
        $enumDecode(_$AchievementLevelEnum, json['achievementLevel']),
    userEmail: json['userEmail'],
    unlockedDate: json['unlockedDate'] != null
        ? DateTime.tryParse(json['unlockedDate'])
        : null,
    username: json['username'],
  );
}

const _$AchievementLevelEnum = {
  AchievementLevel.common: 'common',
  AchievementLevel.rare: 'rare',
  AchievementLevel.epic: 'epic',
  AchievementLevel.legendary: 'legendary',
};
