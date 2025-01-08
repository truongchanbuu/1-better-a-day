import '../../../../services/hive_crud_service.dart';
import '../../domain/repositories/habit_history_repository.dart';
import '../models/habit_history_model.dart';

class HabitHistoryRepoImpl implements HabitHistoryRepository {
  final HiveCRUDInterface<HabitHistoryModel> crudService;
  HabitHistoryRepoImpl(this.crudService);

  // [CREATE]
  @override
  Future<void> createHabitHistory(HabitHistoryModel habitHistory) async =>
      await crudService.create(habitHistory);

  // [GET]
  @override
  Future<List<HabitHistoryModel>> getHabitHistories() async =>
      await crudService.readAll();

  @override
  Future<List<HabitHistoryModel>> getHabitHistoriesByHabitId(
          String habitId) async =>
      await crudService.readAllByKey('habitId', habitId);

  @override
  Future<HabitHistoryModel?> getHabitHistoryById(String id) async =>
      await crudService.read(id);

  // [UPDATE]
  @override
  Future<void> updateHabitHistory(HabitHistoryModel habitHistory) async =>
      await crudService.update(habitHistory.id, habitHistory);

  // [DELETE]
  @override
  Future<void> deleteHabitHistory(String id) async =>
      await crudService.delete(id);

  @override
  Future<void> deleteAllHistories() async => await crudService.deleteAll();
}
