part of 'reminder_bloc.dart';

sealed class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => [];
}

final class ScheduleReminder extends ReminderEvent {
  final HabitEntity habit;
  final String? specificTime;
  const ScheduleReminder({required this.habit, this.specificTime});

  @override
  List<Object?> get props => [habit, specificTime];
}

class CancelReminder extends ReminderEvent {
  final String habitId;
  const CancelReminder(this.habitId);

  @override
  List<Object> get props => [habitId];
}

final class CancelSpecificReminder extends ReminderEvent {
  final String habitId;
  final String timeString;

  const CancelSpecificReminder(this.habitId, this.timeString);

  @override
  List<Object> get props => [habitId, timeString];
}

final class InitializeReminder extends ReminderEvent {}

final class GrantReminderPermission extends ReminderEvent {}
