part of 'statistic_crud_bloc.dart';

/// Base class for all Statistic CRUD events
sealed class StatisticCrudEvent extends Equatable {
  const StatisticCrudEvent();

  @override
  List<Object> get props => [];
}

final class LoadBriefStatistic extends StatisticCrudEvent {}

final class LoadGeneralStatistic extends StatisticCrudEvent {}

final class LoadActiveStatistic extends StatisticCrudEvent {}

final class LoadPauseStatistic extends StatisticCrudEvent {}

final class LoadFailedStatistic extends StatisticCrudEvent {}

final class LoadAchievedStatistic extends StatisticCrudEvent {}
