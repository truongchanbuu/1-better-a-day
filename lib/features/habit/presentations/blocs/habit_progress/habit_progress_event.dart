part of 'habit_progress_bloc.dart';

sealed class HabitProgressEvent extends Equatable {
  const HabitProgressEvent();

  @override
  List<Object> get props => [];
}

final class CheckHabitDaily extends HabitProgressEvent {}
