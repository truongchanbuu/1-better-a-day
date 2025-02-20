part of 'sync_cubit.dart';

sealed class SyncState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SyncInitial extends SyncState {}

final class SyncInProgress extends SyncState {}

final class SyncSuccess extends SyncState {
  final String message;
  SyncSuccess([this.message = 'Sync successfully']);

  @override
  List<Object?> get props => [message];
}

final class SyncFailure extends SyncState {
  final String error;
  SyncFailure(this.error);

  @override
  List<Object?> get props => [error];
}
