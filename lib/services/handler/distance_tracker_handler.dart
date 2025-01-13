import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';

import '../../config/foreground_service/distance_tracker_notification_config.dart';
import '../../core/extensions/num_extension.dart';

@pragma('vm:entry-point')
void startLocationCallback() {
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  DistanceTrackingServiceData distanceData = DistanceTrackingServiceData.init();

  Timer? _timer;
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _timer?.cancel();
    distanceData = DistanceTrackingServiceData.init();
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        await _updateLocation();

        distanceData = distanceData.copyWith(timestamp: timestamp);
        FlutterForegroundTask.updateService(
          notificationTitle:
              DistanceTrackerNotificationConfig.notificationInitialTitle,
          notificationText:
              'Total distance: ${distanceData.currentDistance.toStringAsFixedWithoutZero()} m',
          notificationButtons: DistanceTrackerNotificationConfig.buttons,
        );

        FlutterForegroundTask.sendDataToMain(distanceData);
      },
    );
  }

  @override
  void onReceiveData(Object data) {
    super.onReceiveData(data);
    if (data is String) {
      onNotificationButtonPressed(data);
    }
  }

  @override
  void onNotificationButtonPressed(String id) {
    switch (id) {
      case 'stopButton':
        onDestroy(DateTime.now());
        break;
    }
    super.onNotificationButtonPressed(id);
  }

  Future<void> _updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      final lastPosition = distanceData.lastPosition;
      if (lastPosition != null) {
        double distance = Geolocator.distanceBetween(
          lastPosition.latitude,
          lastPosition.longitude,
          newPosition.latitude,
          newPosition.longitude,
        );

        // Only update if the distance is reasonable (to filter out GPS jumps)
        if (distance < 100) {
          // Maximum 100 meters per update
          distanceData = distanceData.copyWith(
              currentDistance: distanceData.currentDistance + distance);
        }
      }

      distanceData = distanceData.copyWith(lastPosition: newPosition);
    } catch (e) {
      log('Error getting location: $e');
    }
  }
}

class DistanceTrackingServiceData extends Equatable {
  final double currentDistance;
  final Position? lastPosition;
  final DateTime? timestamp;

  const DistanceTrackingServiceData({
    this.currentDistance = 0,
    this.lastPosition,
    this.timestamp,
  });

  @override
  List<Object?> get props => [currentDistance, lastPosition, timestamp];

  factory DistanceTrackingServiceData.init() {
    return const DistanceTrackingServiceData(currentDistance: 0);
  }

  DistanceTrackingServiceData copyWith({
    double? currentDistance,
    Position? lastPosition,
    DateTime? timestamp,
  }) {
    return DistanceTrackingServiceData(
      currentDistance: currentDistance ?? this.currentDistance,
      lastPosition: lastPosition ?? this.lastPosition,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
