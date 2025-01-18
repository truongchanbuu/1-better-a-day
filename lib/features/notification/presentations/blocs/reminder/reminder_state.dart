part of 'reminder_bloc.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

final class ReminderInitial extends ReminderState {}

final class ReminderScheduled extends ReminderState {}

final class ReminderCanceled extends ReminderState {}

class ReminderError extends ReminderState {
  final String message;
  const ReminderError(this.message);

  @override
  List<Object> get props => [message];
}

final class ReminderPermissionDenied extends ReminderState {
  final DateTime timestamp;
  ReminderPermissionDenied() : timestamp = DateTime.now();

  @override
  List<Object> get props => [timestamp];
}

final class ReminderPermissionAllowed extends ReminderState {}
