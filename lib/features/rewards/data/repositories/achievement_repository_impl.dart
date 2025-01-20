import '../../../../services/hive_crud_service.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../models/achievement_model.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  final HiveCRUDInterface<AchievementModel> crudService;
  AchievementRepositoryImpl(this.crudService);

  // [CREATE]
  @override
  Future<void> createAchievement(AchievementModel achievement) async =>
      await crudService.create(achievement);

  // [DELETE]
  @override
  Future<void> deleteAll() async => await crudService.deleteAll();
  @override
  Future<void> deleteById(String achievementId) async =>
      await crudService.delete(achievementId);

  // [READ]
  @override
  Future<AchievementModel?> getAchievementById(String achievementId) async =>
      await crudService.read(achievementId);

  @override
  Future<List<AchievementModel>> getAllLocalAchievements() async =>
      await crudService.readAll();

  @override
  Future<List<AchievementModel>> getAllOtherPeopleAchievements() {
    // TODO: implement getAllOtherPeopleAchievements
    throw UnimplementedError();
  }

  // [UPDATE]
  @override
  Future<void> updateAchievement(AchievementModel updatedAchievement) async =>
      await crudService.update(
          updatedAchievement.achievementId, updatedAchievement);
}
