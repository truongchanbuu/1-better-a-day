import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/log/app_logger.dart';
import '../config/route/app_route.dart';
import '../core/extensions/time_of_day_extension.dart';
import '../features/habit/domain/entities/habit_entity.dart';
import '../features/habit/domain/entities/habit_frequency.dart';
import '../features/shared/presentations/widgets/dialog/notification_permission_dialog.dart';
import '../injection_container.dart';

class ReminderService {
  static const String markCompletedKey = 'MARK_COMPLETED';
  static const String postponeKey = 'POSTPONE';
  static const String habitReminderChannelKey = 'habit_reminders';
  static const String _permissionKey = 'notification_permission_requested';
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;

  bool _isInit = false;
  bool get isInitialized => _isInit;
  set setInit(bool value) => _isInit = value;

  ReminderService._internal();

  final _appLogger = getIt.get<AppLogger>();

  Future<void> init() async {
    _isInit = true;
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
      languageCode: Intl.getCurrentLocale(),
    );
  }

  Future<bool> requestPermission() async {
    // Request permission
    return await _handleNotificationPermission();
  }

  Future<bool> _handleNotificationPermission() async {
    try {
      // Check if we've requested permission before
      if (!await _shouldRequestPermission()) {
        return true;
      }

      final isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (isAllowed) {
        await _markPermissionRequested();
        return true;
      }

      // Request permission
      final granted = await _requestPermissionWithDialog();
      if (granted) {
        await _markPermissionRequested();
        return true;
      }
    } catch (e) {
      _appLogger.e('Failed to handle notification permission: $e');
    }

    return false;
  }

  Future<bool> _requestPermissionWithDialog() async {
    final context = AppRoute.navigatorKey.currentContext;
    if (context == null) {
      // Fallback to direct request if no context
      _appLogger.w('Context is null. Falling back to direct request.');
      return await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NotificationPermissionDialog(),
    );

    if (result == null) {
      _appLogger.i('User dismissed the notification permission dialog.');
      return false;
    }

    if (result) {
      return await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }

    _appLogger.i('User declined to enable notifications.');
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
    if (!habit.isReminderEnabled) return;

    final time = TimeOfDayExtension.tryParse(timeString);
    if (time == null) {
      throw FormatException('Invalid TimeOfDay format');
    }
    await cancelReminder(habit.habitId, timeString);

    int hour = time.hour;
    int minute = time.minute;

    final frequency = habit.habitGoal.goalFrequency;

    final content = NotificationContent(
      id: '${habit.habitId}$timeString'.hashCode,
      channelKey: habitReminderChannelKey,
      title: habit.habitTitle,
      body: habit.habitDesc,
      category: NotificationCategory.Reminder,
      wakeUpScreen: true,
      actionType: ActionType.Default,
      timeoutAfter: const Duration(seconds: 30),
      groupKey: habit.habitId,
      payload: {'habitId': habit.habitId},
    );

    final List<NotificationActionButton> actionButtons = [
      // NotificationActionButton(
      //   key: markCompletedKey,
      //   label: S.current.mark_as_done,
      // ),
      // NotificationActionButton(
      //   key: postponeKey,
      //   label: S.current.mark_as_pause,
      // ),
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

      case FrequencyType.weekdays:
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
        );
        break;
    }

    _appLogger.i('Notification scheduled: ${habit.habitTitle}');
  }

  Future<bool> _scheduleDailyReminder({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required int hour,
    required int minute,
  }) async {
    try {
      return await AwesomeNotifications().createNotification(
        content: content,
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
        ),
        actionButtons: actionButtons,
      );
    } catch (e) {
      _appLogger.e(e);
      return false;
    }
  }

  Future<bool> _scheduleWeekDayReminders({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required Set<int> weekDays,
    required int hour,
    required int minute,
  }) async {
    try {
      // Schedule separate notification for each weekday
      int scheduledDays = 0;
      for (final weekDay in weekDays) {
        bool isScheduled = await AwesomeNotifications().createNotification(
          content: content.copyWith(
            id: content.id! + weekDay, // Unique ID for each weekday
            map: content.toMap(),
          ),
          schedule: NotificationCalendar(
            hour: hour,
            minute: minute,
            weekday: weekDay,
          ),
          actionButtons: actionButtons,
        );

        if (isScheduled) scheduledDays++;
      }

      return scheduledDays == weekDays.length;
    } catch (e) {
      _appLogger.e(e);
      return false;
    }
  }

  Future<bool> _scheduleMonthlyReminders({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required Set<int> monthlyDates,
    required int hour,
    required int minute,
  }) async {
    try {
      int scheduledDates = 0;
      // Schedule separate notification for each monthly date
      for (final date in monthlyDates) {
        bool isScheduled = await AwesomeNotifications().createNotification(
          content: content.copyWith(
            id: content.id! + date, // Unique ID for each date
            map: content.toMap(),
          ),
          schedule: NotificationCalendar(
            hour: hour,
            minute: minute,
            day: date,
          ),
          actionButtons: actionButtons,
        );

        if (isScheduled) scheduledDates++;
      }

      return scheduledDates == monthlyDates.length;
    } catch (e) {
      _appLogger.e(e);
      return false;
    }
  }

  Future<bool> _scheduleIntervalReminder({
    required NotificationContent content,
    required List<NotificationActionButton> actionButtons,
    required HabitFrequency frequency,
  }) async {
    try {
      final interval = frequency.interval!;

      final duration = switch (interval.type) {
        IntervalType.minutes => Duration(minutes: interval.value),
        IntervalType.hours => Duration(hours: interval.value),
        IntervalType.days => Duration(days: interval.value),
        IntervalType.months => Duration(days: interval.value * 30),
      };

      return await AwesomeNotifications().createNotification(
        content: content,
        schedule: NotificationInterval(
          interval: duration,
        ),
        actionButtons: actionButtons,
      );
    } catch (e) {
      _appLogger.e(e);
      return false;
    }
  }

  Future<void> cancelReminder(String habitId, String timeString) async {
    await AwesomeNotifications().cancel('$habitId$timeString'.hashCode);
    _appLogger.i('Notification Canceled: $habitId');
  }

  Future<void> cancelAllHabitReminders(String habitId) async {
    await AwesomeNotifications().cancelNotificationsByGroupKey(habitId);
    _appLogger.i('Notifications Canceled: $habitId');
  }

  Future<void> cancelExpiredHabitNotification(HabitEntity habit) async {
    if (DateTime.now().isAfter(habit.endDate)) {
      await cancelAllHabitReminders(habit.habitId);
      _appLogger
          .i('Notification Deleted Based on Due Date: ${habit.habitTitle}');
    }
  }

  Future<void> getAllScheduledNotifications() async {
    try {
      // Fetch all scheduled notifications
      final List<NotificationModel> scheduledNotifications =
          await AwesomeNotifications().listScheduledNotifications();

      // Print the details of each notification
      for (final notification in scheduledNotifications) {
        print('Notification ID: ${notification.content?.id}');
        print('Title: ${notification.content?.title}');
        print('Body: ${notification.content?.body}');
        print('Channel Key: ${notification.content?.channelKey}');
        print('Schedule: ${notification.schedule}');
        print('--------------------------------------');
      }

      if (scheduledNotifications.isEmpty) {
        _appLogger.i('No scheduled notifications found.');
      }
    } catch (e) {
      _appLogger.e('Error fetching scheduled notifications: $e');
    }
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
