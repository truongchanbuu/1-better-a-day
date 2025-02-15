import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../../../../../config/foreground_service/time_tracker_notification_config.dart';
import '../../../../../services/handler/time_tracker_handler.dart';

part 'habit_time_tracker_event.dart';
part 'habit_time_tracker_state.dart';

class HabitTimeTrackerBloc
    extends Bloc<HabitTimeTrackerEvent, HabitTimeTrackerState> {
  final int targetTime;
  bool _isForegroundAllowed = false;

  HabitTimeTrackerBloc(this.targetTime)
      : super(TimeInitial(targetTime: targetTime)) {
    FlutterForegroundTask.addTaskDataCallback(_onReceived);
    on<TimeTrackingInit>(_onInitialize);
    on<StartTracking>(_onStartTrack);
    on<PauseTracking>(_onPauseTrack);
    on<ResumeTracking>(_onResumeTrack);
    on<RestartTracking>(_onRestartTrack);
    on<UpdateProgress>(_onUpdateProgress);
    on<StartSendCurrentTime>(_onStartSend);
    on<StartTrackingWithoutForeground>(_onStartWithoutForeground);
    on<CompleteTracking>(_onCompleted);
    on<StopTracking>(_onStopped);
  }

  Timer? _timer;
  int _elapsedTime = 0;

  FutureOr<void> _onStatusChanged(String? status) async {
    switch (status) {
      case 'pauseButton':
        add(PauseTracking());
        break;
      case 'resumeButton':
        add(ResumeTracking());
        break;
      case 'stopButton':
        add(StopTracking());
        break;
      case 'restartButton':
        add(RestartTracking());
        break;
    }
  }

  void _completeTracking(int data) {
    if (data >= targetTime) {
      add(CompleteTracking());
    }
  }

  void _onReceived(Object data) {
    if (data is int) {
      add(UpdateProgress(data));
    } else if (data is String) {
      _onStatusChanged(data);
    }
  }

  FutureOr<void> _onCompleted(
      CompleteTracking event, Emitter<HabitTimeTrackerState> emit) async {
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.sendDataToTask('stopButton');
    } else {
      _timer?.cancel();
    }
    emit(TimeTrackSucceed(state));
  }

  FutureOr<void> _onInitialize(
    TimeTrackingInit event,
    Emitter<HabitTimeTrackerState> emit,
  ) async {
    final permissionResults = await _requestPermissions();

    _isForegroundAllowed =
        permissionResults.values.every((isGranted) => isGranted);

    if (_isForegroundAllowed) {
      _initService();
      emit(TimeTrackAllowed(state));
      add(StartTracking());
    } else {
      emit(TimeTrackDenied(state));
      add(StartTrackingWithoutForeground());
    }
  }

  FutureOr<void> _onStartWithoutForeground(StartTrackingWithoutForeground event,
      Emitter<HabitTimeTrackerState> emit) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime++;
      add(UpdateProgress(_elapsedTime));
    });
  }

  FutureOr<void> _onStartTrack(
    StartTracking event,
    Emitter<HabitTimeTrackerState> emit,
  ) async {
    try {
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.stopService();
      }

      await FlutterForegroundTask.saveData(
        key: 'targetTime',
        value: targetTime,
      );

      FlutterForegroundTask.startService(
        notificationTitle: TimeTrackerNotificationConfig.title,
        notificationText: TimeTrackerNotificationConfig.initialText(targetTime),
        notificationButtons: TimeTrackerNotificationConfig.buttons(),
        callback: startTimeTrackerCallback,
      );

      emit(TimeStart(state));
    } catch (e) {
      emit(TimeTrackFailed(
        current: state,
        errorMessage: 'Failed to start timer: ${e.toString()}',
      ));
    }
  }

  FutureOr<void> _onPauseTrack(
    PauseTracking event,
    Emitter<HabitTimeTrackerState> emit,
  ) async {
    if (_isForegroundAllowed) {
      FlutterForegroundTask.sendDataToTask('pauseButton');
    } else {
      _timer?.cancel();
    }

    emit(TimePaused(state));
  }

  FutureOr<void> _onResumeTrack(
      ResumeTracking event, Emitter<HabitTimeTrackerState> emit) async {
    if (_isForegroundAllowed) {
      FlutterForegroundTask.sendDataToTask('resumeButton');
    } else {
      add(StartTrackingWithoutForeground());
    }
  }

  FutureOr<void> _onRestartTrack(
      RestartTracking event, Emitter<HabitTimeTrackerState> emit) async {
    if (_isForegroundAllowed) {
      if (await FlutterForegroundTask.isRunningService) {
        FlutterForegroundTask.sendDataToTask('restartButton');
      } else {
        add(StartTracking());
      }
    } else {
      _elapsedTime = 0;
    }

    emit(TimeRestart(state));
  }

  FutureOr<void> _onUpdateProgress(
      UpdateProgress event, Emitter<HabitTimeTrackerState> emit) {
    emit(TimeTracking(state, currentTime: event.currentTime));
    _completeTracking(state.currentTime);
  }

  FutureOr<void> _onStartSend(
      StartSendCurrentTime event, Emitter<HabitTimeTrackerState> emit) async {
    FlutterForegroundTask.sendDataToTask(event.currentTime);
  }

  FutureOr<void> _onStopped(
      StopTracking event, Emitter<HabitTimeTrackerState> emit) async {
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.sendDataToTask('stopButton');
    } else {
      _timer?.cancel();
    }

    emit(TimeStop(state));
  }

  Future<Map<String, bool>> _requestPermissions() async {
    final Map<String, bool> permissionStatus = {};

    // Check and request notification permission
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission == NotificationPermission.granted) {
      permissionStatus['notification'] = true;
    } else {
      await FlutterForegroundTask.requestNotificationPermission();
      final recheckNotificationPermission =
          await FlutterForegroundTask.checkNotificationPermission();
      permissionStatus['notification'] =
          recheckNotificationPermission == NotificationPermission.granted;
    }

    if (Platform.isAndroid) {
      // Check and request battery optimizations permission
      if (await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        permissionStatus['batteryOptimization'] = true;
      } else {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
        permissionStatus['batteryOptimization'] =
            await FlutterForegroundTask.isIgnoringBatteryOptimizations;
      }

      // Check and request exact alarms permission
      if (await FlutterForegroundTask.canScheduleExactAlarms) {
        permissionStatus['exactAlarms'] = true;
      } else {
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
        permissionStatus['exactAlarms'] =
            await FlutterForegroundTask.canScheduleExactAlarms;
      }
    }

    return permissionStatus;
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'habit_time_tracker',
        channelName: 'Timer Tracker',
        channelDescription:
            'This notification appears when tracking time-based habit.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        allowWifiLock: true,
        autoRunOnBoot: false,
      ),
    );
  }

  @override
  Future<void> close() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceived);
    FlutterForegroundTask.stopService();
    _timer?.cancel();
    return super.close();
  }
}
