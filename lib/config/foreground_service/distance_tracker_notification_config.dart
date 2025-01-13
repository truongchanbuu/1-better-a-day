import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class DistanceTrackerNotificationConfig {
  static const notificationChannelId = 'habit_distance_tracker';
  static const notificationId = 111;
  static const notificationInitialTitle = 'Distance Tracking';
  static const List<NotificationButton> buttons = [
    NotificationButton(id: 'stopButton', text: 'Stop'),
  ];
}
