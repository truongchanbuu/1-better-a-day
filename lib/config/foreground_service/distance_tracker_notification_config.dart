import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class DistanceTrackerNotificationConfig {
  static const notificationChannelId = 'habit_distance_tracker';
  static const notificationId = 111;
  static const notificationInitialTitle = 'Distance Tracking';
  static List<NotificationButton> buttons([isPaused = false]) => [
        const NotificationButton(
          id: 'stopButton',
          text: 'Stop',
          textColor: Colors.red,
        ),
        // NotificationButton(
        //   id: 'pauseButton',
        //   text: isPaused ? 'Resume' : 'Pause',
        // ),
      ];
}
