import '../../data/models/reminder_model.dart';

abstract interface class ReminderRepository {
  Future<void> createReminder(ReminderModel reminder);
  Future<void> updateReminder(ReminderModel updatedReminder);
  Future<ReminderModel?> getReminderById(String id);
  Future<List<ReminderModel>> getAllReminders();
  Future<List<ReminderModel>> getRemindersByHabitId(String habitId);
}
