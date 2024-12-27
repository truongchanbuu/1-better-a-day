import '../../data/models/habit_model.dart';

abstract interface class HabitRepository {
  Future<void> createHabit(HabitModel habit);
  Future<HabitModel?> getHabitById(String id);
  Future<List<HabitModel>> getHabitsByName(String name);
  Future<List<HabitModel>> getHabitsByCategory(String category);
  Future<List<HabitModel>> getHabitsByStatus(String status);
  Future<List<HabitModel>> getAllHabit();
  Future<void> updateHabit(String id, HabitModel updated);
  Future<void> deleteHabitById(String id);
}
