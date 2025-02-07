part of 'share_habit_bloc.dart';

sealed class ShareHabitState extends Equatable {
  const ShareHabitState();

  @override
  List<Object?> get props => [];
}

final class ShareHabitInitial extends ShareHabitState {}

final class ShareHabitLoading extends ShareHabitState {}

final class ShareHabitSuccess extends ShareHabitState {}

final class ShareHabitFailure extends ShareHabitState {
  final String error;
  const ShareHabitFailure(this.error);

  @override
  List<Object?> get props => [error];
}
