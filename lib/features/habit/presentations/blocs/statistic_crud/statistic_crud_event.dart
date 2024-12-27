part of 'statistic_crud_bloc.dart';

/// Base class for all Statistic CRUD events
sealed class StatisticCrudEvent extends Equatable {
  const StatisticCrudEvent();

  @override
  List<Object> get props => [];
}

/// Event to create a new habit statistic
final class CreateStatisticEvent extends StatisticCrudEvent {
  final HabitStatisticModel statistic;

  const CreateStatisticEvent(this.statistic);

  @override
  List<Object> get props => [statistic];
}

/// Event to fetch habit statistics
final class ReadStatisticEvent extends StatisticCrudEvent {
  final String habitId;

  const ReadStatisticEvent(this.habitId);

  @override
  List<Object> get props => [habitId];
}

/// Event to update an existing habit statistic
final class UpdateStatisticEvent extends StatisticCrudEvent {
  final HabitStatisticModel statistic;

  const UpdateStatisticEvent(this.statistic);

  @override
  List<Object> get props => [statistic];
}

/// Event to delete a habit statistic
final class DeleteStatisticEvent extends StatisticCrudEvent {
  final String habitId;

  const DeleteStatisticEvent(this.habitId);

  @override
  List<Object> get props => [habitId];
}
