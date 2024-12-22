import '../../data/models/habit_model.dart';

abstract interface class HabitRepository {
  Future<void> createHabit(HabitModel habit);
  Future<HabitModel?> getHabitById(String id);
  Future<List<HabitModel>> getHabitByName(String name);
  Future<List<HabitModel>> getAllHabit();
  Future<void> updateHabit(String id, HabitModel updated);
  Future<void> deleteHabitById(String id);
}
