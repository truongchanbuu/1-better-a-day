part of 'ai_habit_generate_bloc.dart';

sealed class AIHabitGenerateState extends Equatable {
  const AIHabitGenerateState();

  @override
  List<Object> get props => [];
}

final class AIHabitGenerateInitial extends AIHabitGenerateState {}

final class AIGenerating extends AIHabitGenerateState {}

final class AIGenerationFailed extends AIHabitGenerateState {
  final String errorMessage;
  const AIGenerationFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AIGenerationSucceed extends AIHabitGenerateState {
  final HabitEntity habit;
  const AIGenerationSucceed(this.habit);

  @override
  List<Object> get props => [habit];
}

final class AddHabitFailed extends AIHabitGenerateState {
  final String errorMessage;
  const AddHabitFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AddHabitSucceed extends AIHabitGenerateState {
  final HabitEntity habit;
  const AddHabitSucceed(this.habit);

  @override
  List<Object> get props => [habit];
}
