import '../../../../services/hive_crud_service.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../models/reminder_model.dart';

class ReminderRepoImpl implements ReminderRepository {
  final HiveCRUDInterface<ReminderModel> crudService;
  ReminderRepoImpl(this.crudService);

  @override
  Future<void> createReminder(ReminderModel reminder) async =>
      crudService.create(reminder);

  @override
  Future<List<ReminderModel>> getAllReminders() async =>
      await crudService.readAll();

  @override
  Future<ReminderModel?> getReminderById(String id) async =>
      await crudService.read(id);

  @override
  Future<List<ReminderModel>> getRemindersByHabitId(String habitId) async =>
      await crudService.readAllByKey('habitId', habitId);
  @override
  Future<void> updateReminder(ReminderModel updatedReminder) async =>
      await crudService.update(updatedReminder.reminderId, updatedReminder);
}
