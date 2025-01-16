import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../injection_container.dart';
import '../../../../../services/handler/reminder_handler.dart';
import '../../../../../services/reminder_service.dart';
import '../../../../habit/domain/entities/habit_entity.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderService reminderService;
  ReminderBloc(this.reminderService) : super(ReminderInitial()) {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: ReminderHandler.onActionReceivedMethod,
    );
    on<GrantReminderPermission>(_onGrantPermission);
    on<InitializeReminder>(_onInitializeReminder);
    on<ScheduleReminder>(_onScheduleReminder);
    on<CancelReminder>(_onCancelReminder);
  }

  final _appLogger = getIt.get<AppLogger>();

  FutureOr<void> _onGrantPermission(
      GrantReminderPermission event, Emitter<ReminderState> emit) async {
    final isGranted = await reminderService.requestPermission();

    if (!isGranted) {
      emit(ReminderPermissionDenied());
    } else {
      emit(ReminderPermissionAllowed());
    }

    if (!reminderService.isInitialized) {
      add(InitializeReminder());
    }
  }

  FutureOr<void> _onInitializeReminder(
      InitializeReminder event, Emitter<ReminderState> emit) async {
    await reminderService.init();
  }

  Future<void> _onScheduleReminder(
    ScheduleReminder event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      final habit = event.habit;

      // Cancel existing reminders first
      await reminderService.cancelAllHabitReminders(habit.habitId);

      // Schedule new reminders
      for (final timeString in habit.reminderTimes) {
        await reminderService.scheduleReminder(habit, timeString);
      }

      emit(ReminderScheduled());
    } catch (e) {
      _appLogger.e(e);
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onCancelReminder(
    CancelReminder event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      await reminderService.cancelAllHabitReminders(event.habitId);
      emit(ReminderScheduled());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
