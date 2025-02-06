part of 'habit_crud_bloc.dart';

sealed class HabitCrudEvent extends Equatable {
  const HabitCrudEvent();

  @override
  List<Object> get props => [];
}

final class AddHabit extends HabitCrudEvent {
  final HabitEntity habit;
  const AddHabit(this.habit);

  @override
  List<Object> get props => [habit];
}

final class AddListOfHabits extends HabitCrudEvent {
  final List<HabitEntity> habits;
  const AddListOfHabits(this.habits);

  @override
  List<Object> get props => [habits];
}

final class GetHabitById extends HabitCrudEvent {
  final String habitId;
  const GetHabitById(this.habitId);

  @override
  List<Object> get props => [habitId];
}

final class GetAllHabits extends HabitCrudEvent {}

final class GetListOfHabitsByIds extends HabitCrudEvent {
  final List<String> ids;
  const GetListOfHabitsByIds(this.ids);

  @override
  List<Object> get props => [ids];
}

final class GetListOfHabitsByCategory extends HabitCrudEvent {
  final String category;
  const GetListOfHabitsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

final class GetListOfHabitsByStatus extends HabitCrudEvent {
  final String status;
  const GetListOfHabitsByStatus(this.status);

  @override
  List<Object> get props => [status];
}

final class DeleteHabit extends HabitCrudEvent {
  final String id;
  const DeleteHabit(this.id);

  @override
  List<Object> get props => [id];
}

final class EditHabit extends HabitCrudEvent {
  final String id;
  final HabitEntity updatedHabit;
  const EditHabit({required this.id, required this.updatedHabit});

  @override
  List<Object> get props => [id, updatedHabit];
}

final class SearchHabits extends HabitCrudEvent {
  final HabitCategory? category;
  final HabitStatus? status;
  final String? progress;

  const SearchHabits({
    this.category,
    this.status,
    this.progress,
  });
}

final class SearchByKeyword extends HabitCrudEvent {
  final String keyword;
  const SearchByKeyword(this.keyword);

  @override
  List<Object> get props => [keyword];
}

final class PauseHabit extends HabitCrudEvent {
  final HabitEntity habit;
  const PauseHabit(this.habit);

  @override
  List<Object> get props => [habit];
}

final class StopPauseHabit extends HabitCrudEvent {
  final HabitEntity habit;
  const StopPauseHabit(this.habit);

  @override
  List<Object> get props => [habit];
}
