import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../config/route/app_route.dart';
import '../../features/habit/domain/repositories/habit_repository.dart';
import '../../features/habit/presentations/pages/habit_detail_page.dart';
import '../../injection_container.dart';

class ReminderHandler {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.channelKey == 'habit_reminders' &&
        receivedAction.payload != null &&
        receivedAction.payload!.containsKey('habitId')) {
      final habitId = receivedAction.payload!['habitId'];
      final habitRepository = getIt.get<HabitRepository>();

      final habit = await habitRepository.getHabitById(habitId!);
      if (habit == null) return;
      Navigator.of(AppRoute.navigatorKey.currentContext!).push(
        MaterialPageRoute(
            builder: (context) => HabitDetailPage(habit: habit.toEntity())),
      );
    }
  }
}
