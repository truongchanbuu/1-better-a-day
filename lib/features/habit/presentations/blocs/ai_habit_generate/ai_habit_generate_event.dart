part of 'ai_habit_generate_bloc.dart';

sealed class AIHabitGenerateEvent extends Equatable {
  const AIHabitGenerateEvent();

  @override
  List<Object?> get props => [];
}

final class Regenerate extends AIHabitGenerateEvent {}

final class GenerateSMARTHabitGoal extends AIHabitGenerateEvent {
  final String sentence;
  final String language;
  const GenerateSMARTHabitGoal(this.sentence, [this.language = 'en']);

  @override
  List<Object?> get props => [sentence, language];
}

final class AddHabitEvent extends AIHabitGenerateEvent {
  final HabitEntity habit;
  const AddHabitEvent(this.habit);

  @override
  List<Object> get props => [habit];
}
