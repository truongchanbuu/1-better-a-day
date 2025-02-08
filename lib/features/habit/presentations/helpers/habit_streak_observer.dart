import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/extensions/time_of_day_extension.dart';
import '../../../../core/helpers/cached_client.dart';
import '../../../../services/reminder_service.dart';
import '../../../settings/presentations/bloc/settings_cubit.dart';
import '../../domain/repositories/habit_history_repository.dart';
import '../../domain/repositories/habit_repository.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';

class HabitStreakObserver extends WidgetsBindingObserver {
  final HabitRepository habitRepository;
  final HabitHistoryRepository habitHistoryRepository;
  final HabitHistoryCrudBloc habitHistoryCrudBloc;
  final SettingsCubit settingsCubit;
  final CacheClient cachedClient;
  final ReminderService reminderService;
  Timer? _midnightTimer;
  Timer? _lastReminder;
  final _streakUpdateControllers = <StreamController<void>>{};

  static const String lastCheckDateKey = 'last_check_date';
  static const String notificationChannelKey = 'habit_streak_channel';
  static const String notificationChannelName = 'Habit Streak Notifications';
  static const String notificationChannelDescription =
      'Notifications for habit streak reminders';

  HabitStreakObserver({
    required this.habitRepository,
    required this.habitHistoryRepository,
    required this.habitHistoryCrudBloc,
    required this.cachedClient,
    required this.settingsCubit,
    required this.reminderService,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _initializeNotifications();
    _checkAndUpdateStreaks();
    _setupMidnightTimer();

    _setupLastReminderTime();
    _listenToSettingsChanges();
  }

  StreamSubscription<void> addListener(void Function() onStreakUpdate) {
    final controller = StreamController<void>.broadcast();
    _streakUpdateControllers.add(controller);

    return controller.stream.listen((_) => onStreakUpdate());
  }

  void _notifyListeners() {
    for (final controller in _streakUpdateControllers) {
      controller.add(null);
    }
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: notificationChannelKey,
          channelName: notificationChannelName,
          channelDescription: notificationChannelDescription,
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  void _listenToSettingsChanges() {
    settingsCubit.stream.listen((settings) {
      _setupLastReminderTime();
    });
  }

  Future<void> _setupLastReminderTime() async {
    final isGranted = await reminderService.requestPermission();
    if (!isGranted) return;

    _lastReminder?.cancel();

    final lastReminderTimeString = settingsCubit.state.lastReminderTime;
    final lastReminderTime =
        TimeOfDayExtension.tryParse(lastReminderTimeString) ??
            TimeOfDay(hour: 22, minute: 00);

    final now = DateTime.now();
    var nextReminder = DateTime(
      now.year,
      now.month,
      now.day,
      lastReminderTime.hour,
      lastReminderTime.minute,
    );

    // If we've passed today's reminder time, schedule for tomorrow
    if (now.isAfter(nextReminder)) {
      nextReminder = nextReminder.add(const Duration(days: 1));
    }

    final timeUntilReminder = nextReminder.difference(now);

    _lastReminder = Timer(timeUntilReminder, () {
      _showReminderNotification();
      _setupLastReminderTime();
    });
  }

  Future<void> _showReminderNotification() async {
    final incompleteHabits = await _getIncompleteHabits();
    print('Incomplete habits: $incompleteHabits');
    if (incompleteHabits.isEmpty) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 222,
        channelKey: notificationChannelKey,
        title: 'Daily Habits Reminder',
        body:
            'You have ${incompleteHabits.length} habits left to complete today!',
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN_APP',
          label: 'Open App',
        ),
      ],
    );

    print('Notification shown');
  }

  Future<List<String>> _getIncompleteHabits() async {
    List<String> inCompletedHabitIds = [];
    final inProgressHabits =
        await habitRepository.getHabitsByStatus(HabitStatus.inProgress.name);

    final now = DateTime.now();
    final normalizedToday = DateTime(now.year, now.month, now.day);
    for (var habit in inProgressHabits) {
      print("HABIT:: ${habit.habitTitle}");
      final todayHistory =
          (await habitHistoryRepository.getHabitHistoriesByDateRange(
                  habitId: habit.habitId, startDate: normalizedToday))
              .firstOrNull;

      print("TODAY:: ${todayHistory}");
      if (todayHistory == null ||
          todayHistory.executionStatus == DayStatus.inProgress) {
        inCompletedHabitIds.add(habit.habitId);
      }
    }

    return inCompletedHabitIds;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndUpdateStreaks();
      _setupMidnightTimer();
    } else if (state == AppLifecycleState.paused) {
      _midnightTimer?.cancel();
    }
  }

  void _checkAndUpdateStreaks() {
    final now = DateTime.now();
    final lastCheckTimestamp = cachedClient.getInt(lastCheckDateKey);
    if (lastCheckTimestamp == null) {
      cachedClient.setInt(lastCheckDateKey, now.millisecondsSinceEpoch);
      return;
    }

    final lastCheckDate =
        DateTime.fromMillisecondsSinceEpoch(lastCheckTimestamp);

    final lastCheckDay = DateTime(
      lastCheckDate.year,
      lastCheckDate.month,
      lastCheckDate.day,
    );

    final today = DateTime(now.year, now.month, now.day);

    if (today.isAfter(lastCheckDay)) {
      habitHistoryCrudBloc.add(CheckDailyStreaks());
      cachedClient.setInt(lastCheckDateKey, now.millisecondsSinceEpoch);
      _notifyListeners();
    }
  }

  void _setupMidnightTimer() {
    _midnightTimer?.cancel();

    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final millisUntilMidnight = tomorrow.difference(now).inMilliseconds;

    _midnightTimer = Timer(
      Duration(milliseconds: millisUntilMidnight),
      () {
        _checkAndUpdateStreaks();
        _setupMidnightTimer();
      },
    );
  }

  void dispose() {
    for (final controller in _streakUpdateControllers) {
      controller.close();
    }
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    _lastReminder?.cancel();
  }
}
