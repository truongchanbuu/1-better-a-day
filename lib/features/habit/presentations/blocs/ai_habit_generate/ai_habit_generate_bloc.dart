import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/repositories/habit_ai_repository.dart';

part 'ai_habit_generate_event.dart';
part 'ai_habit_generate_state.dart';

class AIHabitGenerateBloc
    extends Bloc<AIHabitGenerateEvent, AIHabitGenerateState> {
  final HabitAIRepository habitAIRepository;
  AIHabitGenerateBloc(this.habitAIRepository)
      : super(AIHabitGenerateInitial()) {
    on<GenerateSMARTHabitGoal>(_onGenerateSMARTHabitGoal);
  }

  FutureOr<void> _onGenerateSMARTHabitGoal(
      GenerateSMARTHabitGoal event, Emitter<AIHabitGenerateState> emit) async {
    emit(AIGenerating());

    final sentence = event.sentence;
    if (sentence.isEmpty) {
      emit(AIGenerationFailed(S.current.empty_field));
    }

    final habitData =
        await habitAIRepository.generateHabitWithSentence(sentence);
    print('HABIT: $habitData');
  }
}
