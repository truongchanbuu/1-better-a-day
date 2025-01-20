import '../../../../core/enums/rewards/achievement_level.dart';
import '../../../../core/enums/rewards/achievement_type.dart';
import '../../../../core/resources/hive_base_model.dart';
import '../../../habit/domain/entities/habit_icon.dart';
import '../../domain/entities/achievements/accumulation_requirement.dart';
import '../../domain/entities/achievements/achievement_entity.dart';
import '../../domain/entities/achievements/achievement_requirement.dart';
import '../../domain/entities/achievements/streak_requirement.dart';
import '../../domain/entities/achievements/time_requirement.dart';

part 'achievement_model.custom.dart';

class AchievementModel extends AchievementEntity
    implements HiveBaseModel<AchievementModel> {
  const AchievementModel({
    required super.achievementId,
    required super.achievementName,
    required super.achievementDesc,
    required super.achievementType,
    required super.achievementRequirement,
    required super.isUnlocked,
    required super.achievementIcon,
    required super.achievementLevel,
    super.unlockedDate,
    super.userEmail,
  });

  factory AchievementModel.fromEntity(AchievementEntity entity) {
    return AchievementModel(
      achievementId: entity.achievementId,
      achievementName: entity.achievementName,
      achievementDesc: entity.achievementDesc,
      achievementType: entity.achievementType,
      achievementRequirement: entity.achievementRequirement,
      isUnlocked: entity.isUnlocked,
      achievementIcon: entity.achievementIcon,
      achievementLevel: entity.achievementLevel,
      unlockedDate: entity.unlockedDate,
      userEmail: entity.userEmail,
    );
  }

  AchievementEntity toEntity() {
    return AchievementEntity(
      achievementId: achievementId,
      achievementName: achievementName,
      achievementDesc: achievementDesc,
      achievementType: achievementType,
      achievementRequirement: achievementRequirement,
      isUnlocked: isUnlocked,
      achievementIcon: achievementIcon,
      achievementLevel: achievementLevel,
      unlockedDate: unlockedDate,
      userEmail: userEmail,
    );
  }

  Map<String, dynamic> toJson() => _$AchievementModelToJson(this);
  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);

  @override
  AchievementModel fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }

  @override
  get key => achievementId;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
