part of 'habit_history_crud_bloc.dart';

sealed class HabitHistoryCrudEvent extends Equatable {
  const HabitHistoryCrudEvent();

  @override
  List<Object?> get props => [];
}

final class HabitHistoryCrudCreate extends HabitHistoryCrudEvent {
  final HabitHistory habitHistory;
  const HabitHistoryCrudCreate(this.habitHistory);

  @override
  List<Object> get props => [habitHistory];
}

final class HabitHistoryCrudRead extends HabitHistoryCrudEvent {
  final String habitHistoryId;
  const HabitHistoryCrudRead(this.habitHistoryId);

  @override
  List<Object> get props => [habitHistoryId];
}

final class HabitHistoryCrudUpdate extends HabitHistoryCrudEvent {
  final HabitHistory habitHistory;
  const HabitHistoryCrudUpdate(this.habitHistory);

  @override
  List<Object> get props => [habitHistory];
}

final class HabitHistoryCrudDelete extends HabitHistoryCrudEvent {
  final String habitHistoryId;
  const HabitHistoryCrudDelete(this.habitHistoryId);

  @override
  List<Object> get props => [habitHistoryId];
}

final class DeleteAllHistoriesByHabitId extends HabitHistoryCrudEvent {
  final String habitId;
  const DeleteAllHistoriesByHabitId(this.habitId);

  @override
  List<Object> get props => [habitId];
}

final class HabitHistoryCrudList extends HabitHistoryCrudEvent {
  const HabitHistoryCrudList();

  @override
  List<Object> get props => [];
}

final class HabitHistoryCrudListByHabitId extends HabitHistoryCrudEvent {
  final String habitId;
  const HabitHistoryCrudListByHabitId(this.habitId);

  @override
  List<Object> get props => [habitId];
}

final class AddWaterHabitHistory extends HabitHistoryCrudEvent {
  final String habitId;
  final double quantity;
  final double targetValue;
  final GoalUnit measurementUnit;

  AddWaterHabitHistory({
    required this.habitId,
    required this.quantity,
    required this.targetValue,
    required this.measurementUnit,
  }) : assert(habitId.isEmpty == false, 'Habit id cannot empty');

  @override
  List<Object> get props => [habitId, quantity, targetValue];
}

final class GetTodayHabitHistory extends HabitHistoryCrudEvent {
  final String habitId;
  final GoalUnit unit;
  final double targetValue;
  const GetTodayHabitHistory({
    required this.habitId,
    required this.unit,
    required this.targetValue,
  });

  @override
  List<Object> get props => [habitId, unit, targetValue];
}

final class SetHabitHistoryStatus extends HabitHistoryCrudEvent {
  final String historyId;
  final DayStatus status;
  const SetHabitHistoryStatus({required this.historyId, required this.status});

  @override
  List<Object> get props => [historyId, status];
}

final class SearchHabitsByFilter extends HabitHistoryCrudEvent {
  final String habitId;
  final DayStatus? status;
  final Mood? mood;
  final String? date;

  const SearchHabitsByFilter({
    required this.habitId,
    this.status,
    this.mood,
    this.date,
  });

  @override
  List<Object?> get props => [habitId, status, mood, date];
}

final class CheckDailyStreaks extends HabitHistoryCrudEvent {}
