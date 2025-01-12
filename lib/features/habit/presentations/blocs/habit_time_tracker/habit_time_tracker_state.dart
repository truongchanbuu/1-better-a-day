part of 'habit_time_tracker_bloc.dart';

sealed class HabitTimeTrackerState extends Equatable {
  final int currentTime;
  final int targetTime;
  final bool isCompleted;
  final String? errorMessage;

  const HabitTimeTrackerState({
    this.currentTime = 0,
    required this.targetTime,
    this.isCompleted = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        currentTime,
        targetTime,
        isCompleted,
        errorMessage,
      ];
}

final class TimeInitial extends HabitTimeTrackerState {
  const TimeInitial({required super.targetTime});
}

final class TimeTracking extends HabitTimeTrackerState {
  TimeTracking(
    HabitTimeTrackerState current, {
    required super.currentTime,
  }) : super(
          targetTime: current.targetTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeStart extends HabitTimeTrackerState {
  TimeStart(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          isCompleted: false,
          errorMessage: null,
          currentTime: 0,
        );
}

final class TimeTrackAllowed extends HabitTimeTrackerState {
  TimeTrackAllowed(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeTrackDenied extends HabitTimeTrackerState {
  TimeTrackDenied(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeTrackFailed extends HabitTimeTrackerState {
  TimeTrackFailed({
    required HabitTimeTrackerState current,
    required super.errorMessage,
  }) : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: false,
        );
}

final class TimePaused extends HabitTimeTrackerState {
  TimePaused(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeResumed extends HabitTimeTrackerState {
  TimeResumed(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeStop extends HabitTimeTrackerState {
  TimeStop(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: current.currentTime,
          isCompleted: current.isCompleted,
          errorMessage: current.errorMessage,
        );
}

final class TimeRestart extends HabitTimeTrackerState {
  TimeRestart(HabitTimeTrackerState current)
      : super(
          targetTime: current.targetTime,
          currentTime: 0,
          isCompleted: false,
          errorMessage: null,
        );
}

final class TimeTrackSucceed extends HabitTimeTrackerState {
  TimeTrackSucceed(HabitTimeTrackerState current)
      : super(
          currentTime: current.currentTime,
          targetTime: current.targetTime,
          isCompleted: true,
        );
}
