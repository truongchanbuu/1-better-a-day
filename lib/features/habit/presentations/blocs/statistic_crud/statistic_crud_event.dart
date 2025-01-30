part of 'statistic_crud_bloc.dart';

/// Base class for all Statistic CRUD events
sealed class StatisticCrudEvent extends Equatable {
  const StatisticCrudEvent();

  @override
  List<Object> get props => [];
}

final class LoadBriefStatistic extends StatisticCrudEvent {}

final class LoadGeneralStatistic extends StatisticCrudEvent {}
