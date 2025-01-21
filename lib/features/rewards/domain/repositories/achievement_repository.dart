import '../../data/models/achievement_model.dart';

abstract interface class AchievementRepository {
  // Local
  Future<void> createAchievement(AchievementModel achievement);
  Future<AchievementModel?> getAchievementById(String achievementId);
  Future<List<AchievementModel>> getAllLocalAchievements();
  Future<void> updateAchievement(AchievementModel updatedAchievement);
  Future<void> deleteById(String achievementId);
  Future<void> deleteAll();

  // Remote
  Future<List<AchievementModel>> getAllOtherPeopleAchievements(
      String currentEmail);
}
