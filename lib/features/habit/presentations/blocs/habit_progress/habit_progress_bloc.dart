import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../injection_container.dart';
import '../../../../../services/reminder_service.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'habit_progress_event.dart';
part 'habit_progress_state.dart';

class HabitProgressBloc extends Bloc<HabitProgressEvent, HabitProgressState> {
  final AppLogger _appLogger = getIt.get<AppLogger>();
  final HabitRepository habitRepository;
  final ReminderService reminderService;
  HabitProgressBloc(this.habitRepository, this.reminderService)
      : super(HabitProgressInitial()) {
    on<CheckHabitDaily>(_onCheckHabitDaily);
    on<CheckProgress>(_onCheckProgress);
  }

  Future<void> _onCheckHabitDaily(
    CheckHabitDaily event,
    Emitter<HabitProgressState> emit,
  ) async {
    try {
      final habits =
          await habitRepository.getHabitsByStatus(HabitStatus.inProgress.name);

      if (habits.isEmpty) {
        return;
      }

      final now = DateTime.now();
      for (var habit in habits) {
        HabitStatus status = habit.habitStatus;
        if (now.isAfter(habit.endDate) && habit.isInProgress) {
          final habitProgress = habit.habitProgress;
          if (habitProgress >= 0.8) {
            status = HabitStatus.achieved;
          } else {
            status = HabitStatus.failed;
          }

          final newHabit = await _updateHabit(habit, status);

          await reminderService.cancelAllHabitReminders(habit.habitId);
          emit(HabitFinished(newHabit));
        }
      }

      emit(CheckCompleted());
    } catch (e) {
      _appLogger.e(e);
      emit(CheckProgressFailed('Failed to check'));
    }
  }

  Future<void> _onCheckProgress(
    CheckProgress event,
    Emitter<HabitProgressState> emit,
  ) async {
    try {
      final habit = HabitModel.fromEntity(event.habit);
      final habitProgress = habit.habitProgress;

      if (habitProgress >= 1 && habit.isInProgress) {
        final newHabit = await _updateHabit(habit, HabitStatus.achieved);
        await reminderService.cancelAllHabitReminders(habit.habitId);
        emit(HabitFinished(newHabit));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(CheckProgressFailed('Failed to check'));
    }
  }

  Future<HabitModel> _updateHabit(
      HabitModel currentHabit, HabitStatus status) async {
    HabitModel newHabit = currentHabit.copyWith(
      habitStatus: status,
      isReminderEnabled: false,
      reminderStates: {
        for (var time in currentHabit.reminderStates.keys) time: false
      },
    );

    await habitRepository.updateHabit(
      currentHabit.habitId,
      newHabit,
    );

    final updatedHabit =
        await habitRepository.getHabitById(currentHabit.habitId);
    if (updatedHabit == null) {
      throw Exception('Failed to update habit');
    }

    return updatedHabit;
  }
}
