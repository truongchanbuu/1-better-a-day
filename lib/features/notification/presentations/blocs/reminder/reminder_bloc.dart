import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/extensions/time_of_day_extension.dart';
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
    // on<InitializeReminder>(_onInitializeReminder);
    on<ScheduleReminder>(_onScheduleReminder);
    on<CancelReminder>(_onCancelReminder);
    on<CancelSpecificReminder>(_onCancelSpecificReminder);
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

    // if (!reminderService.isInitialized) {
    //   add(InitializeReminder());
    // }
  }

  // FutureOr<void> _onInitializeReminder(
  //     InitializeReminder event, Emitter<ReminderState> emit) async {
  //   await reminderService.init();
  // }

  Future<void> _onScheduleReminder(
    ScheduleReminder event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      final habit = event.habit;
      final specificTime = event.specificTime;
      final reminderTimes = habit.reminderTimes;
      final reminderStates = habit.reminderStates;

      if (specificTime != null) {
        _appLogger.i("Checking reminder for specific time: $specificTime");
        final isEnabled = reminderStates[specificTime] ?? false;
        if (isEnabled) {
          _appLogger.i("Scheduling enabled reminder for: $specificTime");
          await reminderService.scheduleReminder(habit, specificTime);
        } else {
          _appLogger.i("Skipping disabled reminder for: $specificTime");
        }
      } else if (reminderTimes.isEmpty &&
          habit.habitGoal.goalFrequency.interval != null) {
        final defaultTime = TimeOfDay.now().toShortString;
        _appLogger.i("Scheduling default reminder for: $defaultTime");
        await reminderService.scheduleReminder(habit, defaultTime);
      } else {
        for (final timeString in reminderTimes) {
          final isEnabled = reminderStates[timeString] ?? false;
          print('IS: $isEnabled - $reminderStates - $timeString');
          if (isEnabled) {
            _appLogger.i("Scheduling enabled reminder for: $timeString");
            await reminderService.scheduleReminder(habit, timeString);
          } else {
            _appLogger.i("Skipping disabled reminder for: $timeString");
          }
        }
      }

      emit(ReminderScheduled());
    } catch (e) {
      _appLogger.e("Error scheduling reminder: $e");
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onCancelReminder(
    CancelReminder event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      await reminderService.cancelAllHabitReminders(event.habitId);
      emit(ReminderCanceled());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  FutureOr<void> _onCancelSpecificReminder(
      CancelSpecificReminder event, Emitter<ReminderState> emit) async {
    try {
      await reminderService.cancelReminder(event.habitId, event.timeString);
      emit(ReminderCanceled());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }
}
