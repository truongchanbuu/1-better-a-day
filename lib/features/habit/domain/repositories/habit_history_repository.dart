import '../../data/models/habit_history_model.dart';

abstract interface class HabitHistoryRepository {
  Future<List<HabitHistoryModel>> getHabitHistories();
  Future<List<HabitHistoryModel>> getHabitHistoriesByHabitId(String habitId);
  Future<HabitHistoryModel?> getHabitHistoryById(String id);
  Future<void> createHabitHistory(HabitHistoryModel habitHistory);
  Future<void> deleteHabitHistory(String id);
  Future<void> updateHabitHistory(HabitHistoryModel habitHistory);
  Future<void> deleteAllHistories();
}
