import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/foreground_service/distance_tracker_notification_config.dart';
import '../../../../../core/helpers/permission_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/handler/distance_tracker_handler.dart';

part 'distance_track_state.dart';

class DistanceTrackCubit extends Cubit<DistanceTrackState> {
  final double targetDistance;

  DistanceTrackCubit({required this.targetDistance})
      : super(DistanceTrackInitial(targetDistance: targetDistance)) {
    FlutterForegroundTask.addTaskDataCallback(_onReceivedData);
  }

  Future<void> startTracking() async {
    FlutterForegroundTask.startService(
      notificationTitle:
          DistanceTrackerNotificationConfig.notificationInitialTitle,
      notificationText: 'Total Distance: 0 m',
      notificationButtons: DistanceTrackerNotificationConfig.buttons(),
      callback: startLocationCallback,
    );

    emit(DistanceTracking(current: state, currentDistance: 0));
  }

  void pauseTracking() {
    FlutterForegroundTask.sendDataToTask('pauseButton');
    emit(DistanceStopped(state));
  }

  void stopTracking() {
    FlutterForegroundTask.sendDataToTask('stopButton');
    emit(DistanceStopped(state));
  }

  Future<bool> get isRunning async =>
      await FlutterForegroundTask.isRunningService;

  @override
  Future<void> close() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceivedData);
    FlutterForegroundTask.stopService();
    return super.close();
  }

  Future<void> initializeService() async {
    bool isGranted = await PermissionHelper.checkAndRequestGeoLocation();
    await PermissionHelper.checkAndRequestPermission(Permission.notification);
    if (!isGranted) {
      emit(DistanceTrackError(state, S.current.not_allow_track));
      return;
    }

    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: DistanceTrackerNotificationConfig.notificationChannelId,
        channelName: 'Distance Tracking Service',
        channelDescription: 'This channel is for tracking distance',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        allowWifiLock: true,
      ),
    );

    startTracking();
  }

  void _onReceivedData(Object data) {
    if (data is Map) {
      final currentData =
          DistanceTrackingServiceData.fromJson(Map<String, dynamic>.from(data));

      if (currentData.currentDistance >= targetDistance) {
        FlutterForegroundTask.stopService();
        emit(DistanceTrackSucceed(state));
        return;
      }

      emit(DistanceTracking(
        current: state,
        currentDistance: currentData.currentDistance,
      ));
    } else if (data is String) {
      _onNotificationButtonPressed(data);
    }
  }

  void _onNotificationButtonPressed(String id) {
    switch (id) {
      case 'stopButton':
        stopTracking();
        break;
    }
  }
}
