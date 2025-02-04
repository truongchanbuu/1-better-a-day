import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../injection_container.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'habit_progress_event.dart';
part 'habit_progress_state.dart';

class HabitProgressBloc extends Bloc<HabitProgressEvent, HabitProgressState> {
  final AppLogger _appLogger = getIt.get<AppLogger>();
  final HabitRepository habitRepository;
  HabitProgressBloc(this.habitRepository) : super(HabitProgressInitial()) {
    on<CheckHabitDaily>(_onCheckHabitDaily);
  }

  Future<void> _onCheckHabitDaily(
      CheckHabitDaily event, Emitter<HabitProgressState> emit) async {
    try {
      final habits =
          await habitRepository.getHabitsByStatus(HabitStatus.inProgress.name);

      if (habits.isEmpty) {
        return;
      }

      final now = DateTime.now();
      for (var habit in habits) {
        HabitStatus status = habit.habitStatus;
        if (now.isAfter(habit.endDate)) {
          final habitProgress = habit.habitProgress;
          if (habitProgress >= 0.8) {
            status = HabitStatus.achieved;
          } else {
            status = HabitStatus.failed;
          }

          final newHabit = habit.copyWith(habitStatus: status);

          await habitRepository.updateHabit(
            habit.habitId,
            newHabit,
          );
        }
      }
    } catch (e) {
      _appLogger.e(e);
      emit(CheckProgressFailed('Failed to check'));
    }
  }
}
