part of 'ai_habit_generate_bloc.dart';

sealed class AIHabitGenerateEvent extends Equatable {
  const AIHabitGenerateEvent();

  @override
  List<Object> get props => [];
}

final class GenerateSMARTHabitGoal extends AIHabitGenerateEvent {
  final String sentence;
  const GenerateSMARTHabitGoal(this.sentence);

  @override
  List<Object> get props => [sentence];
}
