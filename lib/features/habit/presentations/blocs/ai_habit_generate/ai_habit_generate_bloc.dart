import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/repositories/habit_ai_repository.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'ai_habit_generate_event.dart';
part 'ai_habit_generate_state.dart';

class AIHabitGenerateBloc
    extends Bloc<AIHabitGenerateEvent, AIHabitGenerateState> {
  final _appLogger = getIt.get<AppLogger>();

  final HabitRepository habitRepository;
  final HabitAIRepository habitAIRepository;
  AIHabitGenerateBloc(
      {required this.habitRepository, required this.habitAIRepository})
      : super(AIHabitGenerateInitial()) {
    on<GenerateSMARTHabitGoal>(_onGenerateSMARTHabitGoal);
    on<Regenerate>(_onRegenerate);
    on<AddHabitEvent>(_onAddHabit);
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

  FutureOr<void> _onAddHabit(
      AddHabitEvent event, Emitter<AIHabitGenerateState> emit) async {
    emit(AIGenerating());
    try {
      await habitRepository.createHabit(HabitModel.fromEntity(
          event.habit.copyWith(habitStatus: HabitStatus.inProgress.name)));

      final createdHabit =
          await habitRepository.getHabitById(event.habit.habitId);
      if (createdHabit == null) {
        emit(AddHabitFailed(S.current.cannot_generate_habit));
      } else {
        emit(AddHabitSucceed(createdHabit.toEntity()));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(AddHabitFailed(S.current.cannot_generate_habit));
    }
  }

  FutureOr<void> _onRegenerate(
      Regenerate event, Emitter<AIHabitGenerateState> emit) {
    emit(AIHabitGenerateInitial());
  }
}
