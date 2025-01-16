import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/repositories/habit_ai_repository.dart';

part 'ai_habit_generate_event.dart';
part 'ai_habit_generate_state.dart';

class AIHabitGenerateBloc
    extends Bloc<AIHabitGenerateEvent, AIHabitGenerateState> {
  final HabitAIRepository habitAIRepository;
  AIHabitGenerateBloc(this.habitAIRepository)
      : super(AIHabitGenerateInitial()) {
    on<GenerateSMARTHabitGoal>(_onGenerateSMARTHabitGoal);
    on<Regenerate>(_onRegenerate);
  }

  FutureOr<void> _onGenerateSMARTHabitGoal(
      GenerateSMARTHabitGoal event, Emitter<AIHabitGenerateState> emit) async {
    emit(AIGenerating());

    final sentence = event.sentence;
    if (sentence.isEmpty) {
      emit(AIGenerationFailed(S.current.empty_field));
    }

    final habit = await habitAIRepository.generateHabitWithSentence(sentence,
        language: event.language);

    if (habit == null) {
      emit(AIGenerationFailed(S.current.cannot_generate_habit));
    } else {
      emit(AIGenerationSucceed(habit.toEntity()));
    }
  }

  FutureOr<void> _onRegenerate(
      Regenerate event, Emitter<AIHabitGenerateState> emit) {
    emit(AIHabitGenerateInitial());
  }
}
