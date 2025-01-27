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
  final List<HabitHistory> histories;
  const HabitHistoryCrudSuccess(this.type, this.histories);

  @override
  List<Object> get props => [type, histories];
}

final class HabitHistoryCrudFailure extends HabitHistoryCrudState {
  final String message;
  const HabitHistoryCrudFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class DailyHabitCompleted extends HabitHistoryCrudState {
  final HabitHistory history;
  const DailyHabitCompleted(this.history);
  @override
  List<Object> get props => [history];
}

final class DailyHabitSkipped extends HabitHistoryCrudState {
  final HabitHistory history;
  const DailyHabitSkipped(this.history);
  @override
  List<Object> get props => [history];
}
