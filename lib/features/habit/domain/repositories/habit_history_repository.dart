import '../../data/models/habit_history_model.dart';

abstract interface class HabitHistoryRepository {
  Future<List<HabitHistoryModel>> getHabitHistories();
  Future<List<HabitHistoryModel>> getHabitHistoriesByHabitId(String habitId);
  Future<List<HabitHistoryModel>> getHabitHistoriesByDateRange({
    required String habitId,
    required DateTime startDate,
    DateTime? endDate,
  });
  Future<HabitHistoryModel?> getHabitHistoryById(String id);
  Future<void> createHabitHistory(HabitHistoryModel habitHistory);
  Future<void> deleteHabitHistory(String id);
  Future<void> deleteHabitHistoryByDate({
    required String habitId,
    required DateTime date,
  });
  Future<void> updateHabitHistory(HabitHistoryModel habitHistory);
  Future<void> deleteAllHistories();
}
