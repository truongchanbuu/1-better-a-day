import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';

import '../../config/foreground_service/distance_tracker_notification_config.dart';
import '../../core/extensions/num_extension.dart';

@pragma("vm:entry-point")
void startLocationCallback() {
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  DistanceTrackingServiceData distanceData = DistanceTrackingServiceData.init();
  StreamSubscription<Position>? _positionStream;

  static const String currentDistanceKey = 'currentDistance';

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _stopTracker();
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _initLocationStream();
  }

  @override
  void onNotificationButtonPressed(String id) {
    super.onNotificationButtonPressed(id);
    switch (id) {
      case 'stopButton':
        _stopTracker();
        break;
    }
    FlutterForegroundTask.sendDataToMain(id);
  }

  @override
  void onNotificationDismissed() {
    onNotificationButtonPressed('stopButton');
  }

  Future<void> _stopTracker() async {
    await _positionStream?.cancel();
    distanceData = DistanceTrackingServiceData.init();
    FlutterForegroundTask.stopService();
  }

  Future<void> _initLocationStream() async {
    try {
      double currentDistance =
          await FlutterForegroundTask.getData(key: currentDistanceKey) ?? 0;

      if (currentDistance != 0) {
        distanceData = distanceData.copyWith(currentDistance: currentDistance);
      }

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((Position position) {
        _updateLocation(position);
        FlutterForegroundTask.updateService(
          notificationTitle: 'Distance Tracking Active',
          notificationText:
              'Distance: ${distanceData.currentDistance.toStringAsFixedWithoutZero()} m | Speed: ${distanceData.currentSpeed?.toStringAsFixedWithoutZero() ?? "0.0"} m/s',
          notificationButtons:
              DistanceTrackerNotificationConfig.buttons(distanceData.isPaused),
        );

        FlutterForegroundTask.sendDataToMain(distanceData.toJson());
      });
    } catch (e) {
      log('Error initializing location stream: $e');
    }
  }

  void _updateLocation(Position newPosition) {
    if (distanceData.isPaused) return;

    final lastPosition = distanceData.lastPosition;
    if (lastPosition != null) {
      double distance = Geolocator.distanceBetween(
        lastPosition.latitude,
        lastPosition.longitude,
        newPosition.latitude,
        newPosition.longitude,
      );

      // TODO: CHECK SPEED IF NECESSARY
      distanceData = distanceData.copyWith(
        currentDistance: distanceData.currentDistance + distance,
        currentSpeed: newPosition.speed,
        // accuracy: newPosition.accuracy,
        lastUpdateTime: DateTime.now(),
      );
    }

    distanceData = distanceData.copyWith(
      lastPosition: newPosition,
      // locations: [...(distanceData.locations ?? []), newPosition],
    );
  }

  @override
  void onReceiveData(Object data) {
    if (data is String) {
      switch (data) {
        case 'stopButton':
          onDestroy(DateTime.now());
          break;
        case 'pauseButton':
          distanceData =
              distanceData.copyWith(isPaused: !distanceData.isPaused);
          break;
      }
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}
}

class DistanceTrackingServiceData extends Equatable {
  final double currentDistance;
  final Position? lastPosition;
  final DateTime? lastUpdateTime;
  final double? currentSpeed;
  // final double? accuracy;
  final bool isPaused;
  // final List<Position>? locations;

  const DistanceTrackingServiceData({
    this.currentDistance = 0,
    this.lastPosition,
    this.lastUpdateTime,
    this.currentSpeed,
    // this.accuracy,
    this.isPaused = false,
    // this.locations,
  });

  @override
  List<Object?> get props => [
        currentDistance,
        lastPosition,
        lastUpdateTime,
        currentSpeed,
        // accuracy,
        isPaused,
        // locations,
      ];

  factory DistanceTrackingServiceData.init() {
    return const DistanceTrackingServiceData(
      currentDistance: 0,
      // locations: [],
    );
  }

  DistanceTrackingServiceData copyWith({
    double? currentDistance,
    Position? lastPosition,
    DateTime? lastUpdateTime,
    double? currentSpeed,
    // double? accuracy,
    bool? isPaused,
    // List<Position>? locations,
  }) {
    return DistanceTrackingServiceData(
      currentDistance: currentDistance ?? this.currentDistance,
      lastPosition: lastPosition ?? this.lastPosition,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      currentSpeed: currentSpeed ?? this.currentSpeed,
      // accuracy: accuracy ?? this.accuracy,
      isPaused: isPaused ?? this.isPaused,
      // locations: locations ?? this.locations,
    );
  }

  // JSON
  factory DistanceTrackingServiceData.fromJson(Map<String, dynamic> json) {
    return DistanceTrackingServiceData(
      currentDistance: json['currentDistance'] as double? ?? 0,
      lastPosition: Position.fromMap(json['lastPosition']),
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdateTime'] as int)
          : null,
      currentSpeed: json['currentSpeed'] as double?,
      isPaused: json['isPaused'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentDistance': currentDistance,
      'lastPosition': lastPosition?.toJson(),
      'lastUpdateTime': lastUpdateTime?.millisecondsSinceEpoch,
      'currentSpeed': currentSpeed,
      'isPaused': isPaused,
    };
  }
}
