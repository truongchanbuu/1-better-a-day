import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/tracking_status.dart';
import '../../../../../core/helpers/permission_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';

part 'distance_track_state.dart';

class DistanceTrackCubit extends Cubit<DistanceTrackState> {
  final double targetDistance;

  DistanceTrackCubit({required this.targetDistance})
      : super(DistanceTrackInitial(targetDistance: targetDistance));

  final AppLogger _appLogger = getIt.get<AppLogger>();
  StreamSubscription<Position>? _positionStream;
  Position? _lastPosition;

  Future<void> startTracking() async {
    bool isGranted = await PermissionHelper.checkAndRequestGeoLocation();
    if (!isGranted) {
      emit(DistanceTrackError(state, S.current.not_allow_track));
      return;
    }

    emit(DistanceTracking(state));

    _positionStream = Geolocator.getPositionStream().listen(
      (position) => _updatePosition(position),
      onError: (error) {
        _appLogger.e(error);
        emit(DistanceTrackError(state, error.toString()));
      },
    );
  }

  void _updatePosition(Position position) {
    if (_lastPosition != null) {
      final newDistance = state.currentDistance +
          Geolocator.distanceBetween(
            _lastPosition!.latitude,
            _lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );

      emit(DistanceUpdated(state, newDistance));
    }

    _lastPosition = position;
  }

  void stopTracking() {
    _positionStream?.cancel();
    emit(DistanceStopped(state));
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
