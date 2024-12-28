part of 'habit_history_crud_bloc.dart';

sealed class HabitHistoryCrudEvent extends Equatable {
  const HabitHistoryCrudEvent();

  @override
  List<Object> get props => [];
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
  final int quantity;
  final int targetValue;

  AddWaterHabitHistory({
    required this.habitId,
    required this.quantity,
    required this.targetValue,
  }) : assert(habitId.isEmpty == false, 'Habit id cannot empty');

  @override
  List<Object> get props => [habitId, quantity, targetValue];
}
