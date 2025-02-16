import 'package:awesome_notifications/awesome_notifications.dart';
import '../navigator_service.dart';

class ReminderHandler {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.channelKey == 'habit_reminders' &&
        receivedAction.payload != null &&
        receivedAction.payload!.containsKey('habitId')) {
      // Store the habitId for later use
      final habitId = receivedAction.payload!['habitId'];

      // If app is in background/terminated, launch it
      await AwesomeNotifications().getInitialNotificationAction();

      // Use a navigation service or global method
      NavigationService.instance.navigateToHabitDetail(habitId!);
    }
  }
}
