part of 'distance_track_cubit.dart';

sealed class DistanceTrackState extends Equatable {
  final double currentDistance;
  final double targetDistance;
  final TrackingStatus status;

  const DistanceTrackState({
    required this.currentDistance,
    required this.targetDistance,
    required this.status,
  });

  @override
  List<Object?> get props => [currentDistance, targetDistance, status];
}

final class DistanceTrackInitial extends DistanceTrackState {
  const DistanceTrackInitial({
    super.currentDistance = 0.0,
    required super.targetDistance,
    super.status = TrackingStatus.initial,
  });
}
