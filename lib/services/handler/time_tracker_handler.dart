import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../../config/foreground_service/time_tracker_notification_config.dart';
import '../../core/helpers/date_time_helper.dart';

@pragma('vm:entry-point')
void startTimeTrackerCallback() {
  FlutterForegroundTask.setTaskHandler(TimerTaskHandler());
}

class TimerTaskHandler extends TaskHandler {
  Timer? _timer;

  bool _isTimerRunning = false;
  int _elapsedSeconds = 0;
  int targetSecond = 0;

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _elapsedSeconds = 0;
    _isTimerRunning = false;
    _timer?.cancel();
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  void onReceiveData(Object data) {
    super.onReceiveData(data);
    if (data is String) {
      _onAction(data);
    }
  }

  @override
  void onNotificationDismissed() {
    super.onNotificationDismissed();
    FlutterForegroundTask.stopService();
  }

  @override
  Future<void> onStart(timestamp, starter) async {
    _startTime();
  }

  @override
  void onNotificationButtonPressed(String id) async {
    _onAction(id);
    FlutterForegroundTask.sendDataToMain(id);
  }

  void _onAction(String id) {
    switch (id) {
      case 'pauseButton':
        _pauseTime();
        break;
      case 'resumeButton':
        _resumeTime();
        break;
      case 'stopButton':
        _stopService();
        break;
      case 'restartButton':
        _restartTime();
        break;
    }
  }

  void _updateService([
    String? notificationTitle,
    String? notificationText,
    bool isPaused = false,
  ]) {
    FlutterForegroundTask.updateService(
      notificationTitle:
          notificationTitle ?? TimeTrackerNotificationConfig.title,
      notificationText: notificationText ??
          '${DateTimeHelper.getTimeTrackerFromSecond(_elapsedSeconds)} / ${DateTimeHelper.getTimeTrackerFromSecond(targetSecond)}',
      notificationButtons: TimeTrackerNotificationConfig.buttons(isPaused),
    );
  }

  void _pauseTime() {
    if (!_isTimerRunning) return;

    _isTimerRunning = false;
    _timer?.cancel();

    _updateService(
      'Paused',
      'Paused at: ${DateTimeHelper.getTimeTrackerFromSecond(_elapsedSeconds)}',
      true,
    );
  }

  void _resumeTime() {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _elapsedSeconds++;
        _updateService();
        FlutterForegroundTask.sendDataToMain(_elapsedSeconds);
        if (_elapsedSeconds >= targetSecond) {
          _stopService();
        }
      },
    );

    _updateService();
  }

  Future<void> _startTime() async {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    targetSecond = await FlutterForegroundTask.getData(key: 'targetTime');

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _elapsedSeconds++;
        _updateService();
        FlutterForegroundTask.sendDataToMain(_elapsedSeconds);
        if (_elapsedSeconds >= targetSecond) {
          _stopService();
        }
      },
    );
  }

  void _stopService() {
    FlutterForegroundTask.stopService();
    _isTimerRunning = false;
    _timer?.cancel();
    _elapsedSeconds = 0;
  }

  void _restartTime() {
    FlutterForegroundTask.restartService();
  }
}
