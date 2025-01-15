part of 'reminder_bloc.dart';

sealed class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

final class ScheduleReminder extends ReminderEvent {
  final HabitEntity habit;
  const ScheduleReminder(this.habit);

  @override
  List<Object> get props => [habit];
}

class CancelReminder extends ReminderEvent {
  final String habitId;
  const CancelReminder(this.habitId);

  @override
  List<Object> get props => [habitId];
}
