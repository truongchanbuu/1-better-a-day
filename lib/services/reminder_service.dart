import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/route/app_route.dart';
import '../core/constants/app_font_size.dart';
import '../features/habit/domain/entities/habit_entity.dart';
import '../features/habit/domain/entities/habit_frequency.dart';

class ReminderService {
  static const String markCompletedKey = 'MARK_COMPLETED';
  static const String postponeKey = 'POSTPONE';
  static const String habitReminderChannelKey = 'habit_reminders';
  static const String _permissionKey = 'notification_permission_requested';
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  Future<void> init() async {
    await AwesomeNotifications().initialize(
      null, // null = use default app icon
      [
        NotificationChannel(
          channelKey: habitReminderChannelKey,
          channelName: 'Habit Reminders',
          channelDescription: 'Notifications for habit reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFFFFFFFF),
          importance: NotificationImportance.High,
        ),
      ],
    );

    // Request permission
    await _handleNotificationPermission();
  }

  Future<void> _handleNotificationPermission() async {
    try {
      // Check if we've requested permission before
      if (!await _shouldRequestPermission()) {
        return;
      }

      final isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (isAllowed) {
        await _markPermissionRequested();
        return;
      }

      // Request permission
      final granted = await _requestPermissionWithDialog();
      if (granted) {
        await _markPermissionRequested();
      }
    } catch (e) {
      debugPrint('Failed to handle notification permission: $e');
    }
  }

  Future<bool> _requestPermissionWithDialog() async {
    final context = AppRoute.navigatorKey.currentContext;
    if (context == null) {
      // Fallback to direct request if no context
      return await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Enable Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.h3,
          ),
        ),
        content: const Text(
          'To help you build better habits, we\'d like to send you reminders. '
          'Would you like to enable notifications?',
          overflow: TextOverflow.visible,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Not Now'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Enable'),
          ),
        ],
      ),
    );

    if (result ?? false) {
      return await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }
    return false;
  }

  Future<bool> _shouldRequestPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey(_permissionKey);
  }

  Future<void> _markPermissionRequested() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionKey, true);
  }

  Future<void> scheduleReminder(HabitEntity habit, String timeString) async {
    final timeParts = timeString.split(':');
    int hour = int.tryParse(timeParts.first) ?? 0;
    int minute = int.tryParse(timeParts.last) ?? 0;

    final frequency = habit.habitGoal.goalFrequency;

    final content = NotificationContent(
      id: '${habit.habitId}$timeString'.hashCode,
      channelKey: habitReminderChannelKey,
      title: habit.habitTitle,
      body: habit.habitDesc,
      category: NotificationCategory.Reminder,
      wakeUpScreen: true,
      payload: {'habitId': habit.habitId},
    );

    final actionButtons = [
      NotificationActionButton(
        key: markCompletedKey,
        label: 'Mark Completed',
      ),
      NotificationActionButton(
        key: postponeKey,
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
    const int secondsPerMinute = 60;
    const int minutesPerHour = 60;
    const int hoursPerDay = 24;
    const int daysPerMonth = 30;
    int intervalInSeconds = switch (interval.type) {
      IntervalType.minutes => interval.value * secondsPerMinute,
      IntervalType.hours => interval.value * secondsPerMinute * minutesPerHour,
      IntervalType.days =>
        interval.value * secondsPerMinute * minutesPerHour * hoursPerDay,
      IntervalType.months => interval.value *
          secondsPerMinute *
          minutesPerHour *
          hoursPerDay *
          daysPerMonth,
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
