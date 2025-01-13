part of 'distance_track_cubit.dart';

sealed class DistanceTrackState extends Equatable {
  final double currentDistance;
  final double targetDistance;
  final String? errorMessage;

  const DistanceTrackState({
    required this.currentDistance,
    required this.targetDistance,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [currentDistance, targetDistance, errorMessage];
}

final class DistanceTrackInitial extends DistanceTrackState {
  const DistanceTrackInitial({
    super.currentDistance = 0.0,
    required super.targetDistance,
  });
}

final class DistanceTrackSucceed extends DistanceTrackState {
  DistanceTrackSucceed(DistanceTrackState current)
      : super(
          currentDistance: current.currentDistance,
          targetDistance: current.targetDistance,
          errorMessage: current.errorMessage,
        );
}

final class DistanceTrackError extends DistanceTrackState {
  DistanceTrackError(DistanceTrackState current, String errorMessage)
      : super(
          errorMessage: errorMessage,
          currentDistance: current.currentDistance,
          targetDistance: current.targetDistance,
        );
}

final class DistanceTracking extends DistanceTrackState {
  DistanceTracking({
    required DistanceTrackState current,
    required super.currentDistance,
  }) : super(targetDistance: current.targetDistance);
}

final class DistanceStopped extends DistanceTrackState {
  DistanceStopped(DistanceTrackState current)
      : super(
          currentDistance: current.currentDistance,
          targetDistance: current.targetDistance,
        );
}
