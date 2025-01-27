part of 'statistic_crud_bloc.dart';

/// Base state for Statistic CRUD operations
sealed class StatisticCrudState extends Equatable {
  const StatisticCrudState();

  @override
  List<Object?> get props => [];
}

/// Initial state when no action has been performed
final class StatisticCrudInitial extends StatisticCrudState {
  const StatisticCrudInitial();
}

/// State while a CRUD operation is in progress (e.g., loading)
final class StatisticCrudLoading extends StatisticCrudState {
  const StatisticCrudLoading();
}

/// State when a CRUD operation completes successfully
final class StatisticCrudSuccess extends StatisticCrudState {
  final String message; // Optional message to indicate success details
  const StatisticCrudSuccess([this.message = 'Operation successful']);

  @override
  List<Object?> get props => [message];
}

/// State when a CRUD operation fails
final class StatisticCrudFailure extends StatisticCrudState {
  final String error;

  const StatisticCrudFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// State when statistics are successfully loaded
final class StatisticCrudLoaded extends StatisticCrudState {
  final HabitStatisticEntity statistics;
  const StatisticCrudLoaded(this.statistics);

  @override
  List<Object?> get props => [statistics];
}

/// State when a single statistic is successfully fetched
final class StatisticCrudDetailLoaded extends StatisticCrudState {
  final HabitStatisticEntity statistic;

  const StatisticCrudDetailLoaded(this.statistic);

  @override
  List<Object?> get props => [statistic];
}
