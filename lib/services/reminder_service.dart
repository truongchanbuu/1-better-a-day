import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../features/habit/domain/entities/habit_entity.dart';
import '../features/habit/domain/entities/habit_frequency.dart';

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  Future<void> init() async {
    await AwesomeNotifications().initialize(
      null, // null = use default app icon
      [
        NotificationChannel(
          channelKey: 'habit_reminders',
          channelName: 'Habit Reminders',
          channelDescription: 'Notifications for habit reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFFFFFFFF),
          importance: NotificationImportance.High,
        ),
      ],
    );

    // Request permission
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> scheduleReminder(HabitEntity habit, String timeString) async {
    final timeParts = timeString.split(':');
    int hour = int.tryParse(timeParts.first) ?? 0;
    int minute = int.tryParse(timeParts.last) ?? 0;

    final frequency = habit.habitGoal.goalFrequency;

    final content = NotificationContent(
      id: '${habit.habitId}$timeString'.hashCode,
      channelKey: 'habit_reminders',
      title: habit.habitTitle,
      body: habit.habitDesc,
      category: NotificationCategory.Reminder,
      wakeUpScreen: true,
      payload: {'habitId': habit.habitId},
    );

    final actionButtons = [
      NotificationActionButton(
        key: 'MARK_COMPLETED',
        label: 'Mark Completed',
      ),
      NotificationActionButton(
        key: 'POSTPONE',
        label: 'Postpone',
      ),
    ];

    switch (frequency.type) {
      case FrequencyType.daily:
        await _scheduleDailyReminder(
          content: content,
          actionButtons: actionButtons,
          hour: hour,
          minute: minute,
        );
        break;

      case FrequencyType.weekDays:
        await _scheduleWeekDayReminders(
          content: content,
          actionButtons: actionButtons,
          weekDays: frequency.weekDays!,
          hour: hour,
          minute: minute,
        );
        break;

      case FrequencyType.monthly:
        await _scheduleMonthlyReminders(
          content: content,
          actionButtons: actionButtons,
          monthlyDates: frequency.monthlyDates!,
          hour: hour,
          minute: minute,
        );
        break;
      case FrequencyType.interval:
        await _scheduleIntervalReminder(
          content: content,
          actionButtons: actionButtons,
          frequency: frequency,
          hour: hour,
          minute: minute,
        );
        break;
    }
  }

  Future<void> _scheduleDailyReminder({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required int hour,
    required int minute,
  }) async {
    await AwesomeNotifications().createNotification(
      content: content,
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        repeats: true,
      ),
      actionButtons: actionButtons,
    );
  }

  Future<void> _scheduleWeekDayReminders({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required Set<int> weekDays,
    required int hour,
    required int minute,
  }) async {
    // Schedule separate notification for each weekday
    for (final weekDay in weekDays) {
      await AwesomeNotifications().createNotification(
        content: content.copyWith(
          id: content.id! + weekDay, // Unique ID for each weekday
          map: content.toMap(),
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          weekday: weekDay,
          repeats: true,
        ),
        actionButtons: actionButtons,
      );
    }
  }

  Future<void> _scheduleMonthlyReminders({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required Set<int> monthlyDates,
    required int hour,
    required int minute,
  }) async {
    // Schedule separate notification for each monthly date
    for (final date in monthlyDates) {
      await AwesomeNotifications().createNotification(
        content: content.copyWith(
          id: content.id! + date, // Unique ID for each date
          map: content.toMap(),
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          day: date,
          repeats: true,
        ),
        actionButtons: actionButtons,
      );
    }
  }

  Future<void> _scheduleIntervalReminder({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required HabitFrequency frequency,
    required int hour,
    required int minute,
  }) async {
    DateTime nextTriggerDate = frequency.getNextDueTime();

    // If the time has passed today, start from tomorrow
    if (nextTriggerDate.isBefore(DateTime.now())) {
      nextTriggerDate = nextTriggerDate.add(const Duration(days: 1));
    }

    final interval = frequency.interval!;
    // Convert interval to minutes for consistency
    int intervalInSeconds = switch (interval.type) {
      IntervalType.minutes => interval.value * 60,
      IntervalType.hours => interval.value * 60 * 60,
      IntervalType.days => interval.value * 24 * 60 * 60,
      IntervalType.months => interval.value * 30 * 24 * 60 * 60,
    };

    await AwesomeNotifications().createNotification(
      content: content,
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        repeats: true,
        second: intervalInSeconds,
      ),
      actionButtons: actionButtons,
    );
  }

  Future<void> cancelReminder(String habitId, String timeString) async {
    await AwesomeNotifications().cancel('$habitId$timeString'.hashCode);
  }

  Future<void> cancelAllHabitReminders(String habitId) async {
    await AwesomeNotifications().cancelNotificationsByGroupKey(habitId);
  }
}

extension on NotificationContent {
  NotificationContent copyWith({
    required int id,
    required Map<String, dynamic> map,
  }) {
    final currMap = {
      "id": id,
      ...map,
    };

    return fromMap(currMap)!;
  }
}
