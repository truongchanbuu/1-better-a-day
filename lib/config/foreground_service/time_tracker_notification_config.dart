import 'package:flutter_foreground_task/models/notification_button.dart';

import '../../core/helpers/date_time_helper.dart';

class TimeTrackerNotificationConfig {
  static String title = 'Time Tracker';
  static String initialText(int target) =>
      '00:00 / ${DateTimeHelper.getTimeTrackerFromSecond(target)}';
  static List<NotificationButton> buttons([bool isPaused = false]) => [
        NotificationButton(
            id: !isPaused ? 'pauseButton' : 'resumeButton',
            text: !isPaused ? 'Pause' : 'Resume'),
        const NotificationButton(id: 'restartButton', text: 'Restart'),
        const NotificationButton(id: 'stopButton', text: 'Stop'),
      ];
}
