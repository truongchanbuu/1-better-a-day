import '../../data/models/achievement_model.dart';

abstract interface class AchievementRepository {
  Future<void> createAchievement(AchievementModel achievement);
  Future<AchievementModel?> getAchievementById(String achievementId);
  Future<List<AchievementModel>> getAllOtherPeopleAchievements();
  Future<List<AchievementModel>> getAllLocalAchievements();
  Future<void> updateAchievement(AchievementModel updatedAchievement);
  Future<void> deleteById(String achievementId);
  Future<void> deleteAll();
}
