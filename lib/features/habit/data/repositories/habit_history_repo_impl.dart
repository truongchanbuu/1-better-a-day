import 'package:bottom_picker/resources/extensions.dart';
import 'package:collection/collection.dart';

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

  @override
  Future<List<HabitHistoryModel>> getHabitHistoriesByDateRange({
    required String habitId,
    required DateTime startDate,
    DateTime? endDate,
  }) async {
    final histories = await getHabitHistoriesByHabitId(habitId);

    DateTime normalizeDate(DateTime date) =>
        DateTime(date.year, date.month, date.day);

    final normalizedStartDate = normalizeDate(startDate);
    final normalizedEndDate = endDate != null ? normalizeDate(endDate) : null;

    return histories.where((history) {
      final normalizedHistoryDate = normalizeDate(history.date);

      return normalizedHistoryDate.isAtSameMomentOrAfter(normalizedStartDate) &&
          (normalizedEndDate == null ||
              normalizedHistoryDate
                  .isBefore(normalizedEndDate.add(Duration(days: 1))));
    }).toList();
  }

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
  @override
  Future<void> deleteHabitHistoryByDate({
    required String habitId,
    required DateTime date,
  }) async {
    DateTime normalizeDate(DateTime date) =>
        DateTime(date.year, date.month, date.day);

    final normalizedDate = normalizeDate(date);
    final histories = await getHabitHistoriesByHabitId(habitId);

    final historyToDelete = histories.firstWhereOrNull(
      (history) => normalizeDate(history.date).isAtSameMomentAs(normalizedDate),
    );

    if (historyToDelete != null) {
      await deleteHabitHistory(historyToDelete.id);
    }
  }
}
