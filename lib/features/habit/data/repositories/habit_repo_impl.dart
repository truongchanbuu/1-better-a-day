import '../../../../services/hive_crud_service.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';

class HabitRepoImpl implements HabitRepository {
  final HiveCRUDInterface<HabitModel> crudService;
  HabitRepoImpl(this.crudService);

  // [CREATE]
  @override
  Future<void> createHabit(HabitModel habit) async =>
      await crudService.create(habit);

  // [DELETE]
  @override
  Future<void> deleteHabitById(String id) async => await crudService.delete(id);

  @override
  Future<void> deleteAll() async => await crudService.deleteAll();

  // [GET]
  @override
  Future<List<HabitModel>> getAllHabits() async => await crudService.readAll();

  @override
  Future<HabitModel?> getHabitById(String id) async =>
      await crudService.read(id);

  @override
  Future<List<HabitModel>> getHabitsByName(String name) async =>
      await crudService.readAllByKey('habitTitle', name);

  @override
  Future<List<HabitModel>> getHabitsByCategory(String category) async =>
      await crudService.readAllByKey('habitCategory', category);

  @override
  Future<List<HabitModel>> getHabitsByStatus(String status) async =>
      await crudService.readAllByKey('habitStatus', status);

  // [UPDATE]
  @override
  Future<void> updateHabit(String id, HabitModel updated) async =>
      await crudService.update(id, updated);
}
