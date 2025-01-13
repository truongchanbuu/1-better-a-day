import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

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
    // await FlutterForegroundTask.saveData(
    //     key: 'targetDistance', value: targetDistance);

    FlutterForegroundTask.startService(
      notificationTitle:
          DistanceTrackerNotificationConfig.notificationInitialTitle,
      notificationText: 'Total Distance: 0 m',
      notificationButtons: DistanceTrackerNotificationConfig.buttons,
      callback: startLocationCallback,
    );

    emit(DistanceTracking(current: state, currentDistance: 0));
  }

  void stopTracking() {
    FlutterForegroundTask.sendDataToTask('stopButton');
    emit(DistanceStopped(state));
  }

  @override
  Future<void> close() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceivedData);
    return super.close();
  }

  Future<void> initializeService() async {
    bool isGranted = await PermissionHelper.checkAndRequestGeoLocation();
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
    if (data is DistanceTrackingServiceData) {
      emit(DistanceTracking(
        current: state,
        currentDistance: data.currentDistance,
      ));
    }
  }
}
