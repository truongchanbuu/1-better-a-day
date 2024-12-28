part of 'habit_crud_bloc.dart';

enum HabitCrudAction {
  add,
  addList,
  getAll,
  getBySearchValues,
  getByKeyword,
  getByIds,
  getByCategory,
  getByStatus,
  update,
  delete,
}

sealed class HabitCrudState extends Equatable {
  const HabitCrudState();

  @override
  List<Object> get props => [];
}

final class CrudInitial extends HabitCrudState {}

final class Executing extends HabitCrudState {}

final class HabitCrudSucceed extends HabitCrudState {
  final HabitCrudAction action;
  final List<HabitEntity> habits;
  const HabitCrudSucceed({required this.action, required this.habits});

  @override
  List<Object> get props => [action, habits];
}

final class HabitCrudFailed extends HabitCrudState {
  final String errorMessage;
  const HabitCrudFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
