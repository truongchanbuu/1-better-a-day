part of 'reminder_bloc.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

final class ReminderInitial extends ReminderState {}

final class ReminderScheduled extends ReminderState {}

class ReminderError extends ReminderState {
  final String message;
  const ReminderError(this.message);

  @override
  List<Object> get props => [message];
}

final class ReminderPermisssionDenied extends ReminderState {}

final class ReminderPermisssionAllowed extends ReminderState {}
