import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/habit_model.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/repositories/habit_repository.dart';

part 'habit_crud_event.dart';
part 'habit_crud_state.dart';

class HabitCrudBloc extends Bloc<HabitCrudEvent, HabitCrudState> {
  final AppLogger _appLogger = getIt.get<AppLogger>();
  final HabitRepository habitRepository;

  HabitCrudBloc(this.habitRepository) : super(CrudInitial()) {
    on<AddHabit>(_onAddHabit);
    on<AddListOfHabits>(_onAddListOfHabits);
    on<GetAllHabits>(_onGetAllHabits);
    on<GetListOfHabitsByIds>(_onGetListOfHabits);
    on<GetListOfHabitsByCategory>(_onGetHabitsByCategory);
    on<GetListOfHabitsByStatus>(_onGetHabitsByStatus);
    on<SearchHabits>(_onSearchHabits);
    on<SearchByKeyword>(_onSearchByKeyword);
    on<DeleteHabit>(_onDeleteHabit);
    on<EditHabit>(_onEditHabit);
  }

  FutureOr<void> _onAddHabit(
      AddHabit event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      await habitRepository.createHabit(HabitModel.fromEntity(
          event.habit.copyWith(habitStatus: HabitStatus.inProgress)));
      final created = await habitRepository.getHabitById(event.habit.habitId);

      if (created == null) {
        emit(HabitCrudFailed(S.current.cannot_generate_habit));
      } else {
        emit(HabitCrudSucceed(
            action: HabitCrudAction.add, habits: [created.toEntity()]));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_generate_habit));
    }
  }

  FutureOr<void> _onAddListOfHabits(
      AddListOfHabits event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      await Future.wait(event.habits.map((habit) => habitRepository.createHabit(
          HabitModel.fromEntity(
              habit.copyWith(habitStatus: HabitStatus.inProgress)))));

      final createdHabits = await Future.wait(event.habits.map(
          (habit) async => await habitRepository.getHabitById(habit.habitId)));

      if (createdHabits.contains(null) ||
          createdHabits.length != event.habits.length) {
        emit(HabitCrudFailed(S.current.cannot_generate_habit));
        return;
      } else {
        emit(HabitCrudSucceed(
            action: HabitCrudAction.addList,
            habits: createdHabits
                .map((e) => e!)
                .map((e) => e.toEntity())
                .toList()));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_generate_habit));
    }
  }

  FutureOr<void> _onGetListOfHabits(
      GetListOfHabitsByIds event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      List<HabitEntity> habits = [];

      for (var id in event.ids) {
        final habit = await habitRepository.getHabitById(id);

        if (habit != null) {
          habits.add(habit.toEntity());
        }
      }

      emit(HabitCrudSucceed(action: HabitCrudAction.getAll, habits: habits));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onGetHabitsByCategory(
      GetListOfHabitsByCategory event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      List<HabitModel> habits =
          await habitRepository.getHabitsByCategory(event.category);

      emit(HabitCrudSucceed(
          action: HabitCrudAction.getByCategory,
          habits: habits.map((e) => e.toEntity()).toList()));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onGetHabitsByStatus(
      GetListOfHabitsByStatus event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      List<HabitModel> habits =
          await habitRepository.getHabitsByStatus(event.status);

      emit(HabitCrudSucceed(
          action: HabitCrudAction.getByStatus,
          habits: habits.map((e) => e.toEntity()).toList()));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onGetAllHabits(
      GetAllHabits event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      final habits = await habitRepository.getAllHabits();
      emit(HabitCrudSucceed(
          action: HabitCrudAction.getAll,
          habits: habits.map((e) => e.toEntity()).toList()));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onDeleteHabit(
      DeleteHabit event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      final habit = await habitRepository.getHabitById(event.id);

      if (habit == null) {
        emit(HabitCrudFailed(S.current.not_found));
      } else {
        await habitRepository.deleteHabitById(event.id);
        emit(HabitCrudSucceed(
            action: HabitCrudAction.delete, habits: [habit.toEntity()]));
      }
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onEditHabit(
      EditHabit event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      final habit = await habitRepository.getHabitById(event.id);
      if (habit == null) {
        emit(HabitCrudFailed(S.current.not_found));
      } else {
        if (habit.toEntity() != event.updatedHabit) {
          await habitRepository.updateHabit(
              event.id, HabitModel.fromEntity(event.updatedHabit));
        }

        final updatedOne = await habitRepository.getHabitById(event.id);
        if (updatedOne?.toEntity() != event.updatedHabit) {
          emit(HabitCrudFailed(S.current.cannot_update_habit));
        } else {
          emit(HabitCrudSucceed(
              action: HabitCrudAction.update,
              habits: [updatedOne!.toEntity()]));
        }
      }
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onSearchHabits(
      SearchHabits event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      List<HabitEntity> habits = (await habitRepository.getAllHabits())
          .map((e) => e.toEntity())
          .toList();

      if (event.category != null) {
        habits = habits
            .where((habit) => habit.habitCategory == event.category)
            .toList();
      }

      if (event.status != null) {
        habits =
            habits.where((habit) => habit.habitStatus == event.status).toList();
      }

      if (event.progress?.isNotEmpty ?? false) {
        String cleanProgress = event.progress!.split('%').first;
        if (cleanProgress.contains('-')) {
          final range = cleanProgress.split('-');
          habits = habits.where((habit) {
            final progress = habit.habitProgress;
            return progress >= int.parse(range.first) &&
                progress <= int.parse(range.last);
          }).toList();
        } else {
          habits = habits
              .where(
                  (habit) => habit.habitProgress == double.parse(cleanProgress))
              .toList();
        }
      }

      emit(HabitCrudSucceed(
          action: HabitCrudAction.getBySearchValues, habits: habits));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }

  FutureOr<void> _onSearchByKeyword(
      SearchByKeyword event, Emitter<HabitCrudState> emit) async {
    emit(Executing());
    try {
      final habits = (await habitRepository.getAllHabits())
          .map((e) => e.toEntity())
          .toList();

      if (event.keyword.isEmpty) {
        emit(HabitCrudFailed(S.current.cannot_get_any_habit));
        return;
      }

      final filteredHabits = habits.where((habit) {
        final keyword = event.keyword.toLowerCase();
        return habit.habitTitle.toLowerCase().contains(keyword) ||
            habit.habitDesc.toLowerCase().contains(keyword) ||
            habit.habitGoal.goalDesc.toLowerCase().contains(keyword) ||
            habit.habitCategory.name.toLowerCase().contains(keyword);
      }).toList();

      emit(HabitCrudSucceed(
        action: HabitCrudAction.getByKeyword,
        habits: filteredHabits,
      ));
    } catch (e) {
      _appLogger.e(e);
      emit(HabitCrudFailed(S.current.cannot_get_any_habit));
    }
  }
}
