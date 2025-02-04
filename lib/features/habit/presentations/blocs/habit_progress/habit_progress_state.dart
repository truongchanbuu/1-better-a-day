part of 'habit_progress_bloc.dart';

sealed class HabitProgressState extends Equatable {
  const HabitProgressState();

  @override
  List<Object?> get props => [];
}

final class HabitProgressInitial extends HabitProgressState {}

final class CheckProgressFailed extends HabitProgressState {
  final String? errorMessage;
  const CheckProgressFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
