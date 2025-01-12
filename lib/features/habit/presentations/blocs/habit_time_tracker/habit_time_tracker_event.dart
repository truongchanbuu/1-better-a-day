part of 'habit_time_tracker_bloc.dart';

sealed class HabitTimeTrackerEvent extends Equatable {
  const HabitTimeTrackerEvent();

  @override
  List<Object> get props => [];
}

final class TimeTrackingInit extends HabitTimeTrackerEvent {}

final class StartTracking extends HabitTimeTrackerEvent {}

final class RestartTracking extends HabitTimeTrackerEvent {}

final class PauseTracking extends HabitTimeTrackerEvent {}

final class ResumeTracking extends HabitTimeTrackerEvent {}

final class StartTrackingWithoutForeground extends HabitTimeTrackerEvent {}

final class StartSendCurrentTime extends HabitTimeTrackerEvent {
  final int currentTime;

  const StartSendCurrentTime(this.currentTime);
  @override
  List<Object> get props => [currentTime];
}

final class StopTracking extends HabitTimeTrackerEvent {}

final class UpdateProgress extends HabitTimeTrackerEvent {
  final int currentTime;
  const UpdateProgress(this.currentTime);

  @override
  List<Object> get props => [currentTime];
}

final class CompleteTracking extends HabitTimeTrackerEvent {}
