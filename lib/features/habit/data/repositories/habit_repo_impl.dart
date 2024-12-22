import '../../../../services/hive_crud_service.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';

class HabitRepoImpl implements HabitRepository {
  final HiveCRUDInterface<HabitModel> crudService;
  HabitRepoImpl(this.crudService);

  @override
  Future<void> createHabit(HabitModel habit) async =>
      await crudService.create(habit);

  @override
  Future<void> deleteHabitById(String id) async => await crudService.delete(id);

  @override
  Future<List<HabitModel>> getAllHabit() async => await crudService.readAll();

  @override
  Future<HabitModel?> getHabitById(String id) async =>
      await crudService.read(id);

  @override
  Future<List<HabitModel>> getHabitByName(String name) async =>
      await crudService.readAllByKey(name);

  @override
  Future<void> updateHabit(String id, HabitModel updated) async =>
      await crudService.update(id, updated);
}
