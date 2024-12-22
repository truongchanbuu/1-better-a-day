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
