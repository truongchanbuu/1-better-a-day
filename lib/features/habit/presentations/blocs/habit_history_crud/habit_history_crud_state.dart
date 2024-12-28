part of 'habit_history_crud_bloc.dart';

enum HabitHistoryCrudEventType {
  create,
  read,
  update,
  delete,
  list,
}

sealed class HabitHistoryCrudState extends Equatable {
  const HabitHistoryCrudState();

  @override
  List<Object> get props => [];
}

final class HabitHistoryCrudInitial extends HabitHistoryCrudState {}

final class HabitHistoryCrudInProgress extends HabitHistoryCrudState {}

final class HabitHistoryCrudSuccess extends HabitHistoryCrudState {
  final HabitHistoryCrudEventType type;
  final List<HabitHistory> habitHistory;
  const HabitHistoryCrudSuccess(this.type, this.habitHistory);

  @override
  List<Object> get props => [type, habitHistory];
}

final class HabitHistoryCrudFailure extends HabitHistoryCrudState {
  final String message;
  const HabitHistoryCrudFailure(this.message);

  @override
  List<Object> get props => [message];
}
