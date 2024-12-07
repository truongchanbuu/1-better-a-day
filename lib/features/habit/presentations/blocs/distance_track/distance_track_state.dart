part of 'distance_track_cubit.dart';

sealed class DistanceTrackState extends Equatable {
  final double currentDistance;
  final double targetDistance;
  final TrackingStatus status;
  final String? errorMessage;

  const DistanceTrackState({
    required this.currentDistance,
    required this.targetDistance,
    required this.status,
    this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [currentDistance, targetDistance, status, errorMessage];
}

final class DistanceTrackInitial extends DistanceTrackState {
  const DistanceTrackInitial({
    super.currentDistance = 0.0,
    required super.targetDistance,
    super.status = TrackingStatus.initial,
  });
}

final class DistanceTrackError extends DistanceTrackState {
  DistanceTrackError(DistanceTrackState current, String errorMessage)
      : super(
          status: TrackingStatus.error,
          errorMessage: errorMessage,
          currentDistance: current.currentDistance,
          targetDistance: current.targetDistance,
        );
}

final class DistanceTracking extends DistanceTrackState {
  DistanceTracking(DistanceTrackState current)
      : super(
          targetDistance: current.targetDistance,
          currentDistance: current.currentDistance,
          status: TrackingStatus.tracking,
        );
}

final class DistanceUpdated extends DistanceTrackState {
  DistanceUpdated(DistanceTrackState current, double currentDistance)
      : super(
          targetDistance: current.targetDistance,
          currentDistance: currentDistance,
          status: TrackingStatus.tracking,
        );
}

final class DistanceStopped extends DistanceTrackState {
  DistanceStopped(DistanceTrackState current)
      : super(
          status: TrackingStatus.paused,
          currentDistance: current.currentDistance,
          targetDistance: current.targetDistance,
        );
}
