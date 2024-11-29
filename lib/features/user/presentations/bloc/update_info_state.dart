part of 'update_info_cubit.dart';

sealed class UpdateInfoState extends Equatable {
  const UpdateInfoState();

  @override
  List<Object> get props => [];
}

final class UpdateInfoInitial extends UpdateInfoState {}

final class UpdateSucceed extends UpdateInfoState {}

final class UpdateFailed extends UpdateInfoState {
  final String message;
  const UpdateFailed(this.message);

  @override
  List<Object> get props => [message];
}
