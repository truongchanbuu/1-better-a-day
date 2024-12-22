part of 'internet_bloc.dart';

sealed class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

final class CheckInternetConnection extends InternetEvent {}

final class InternetConnectionChanged extends InternetEvent {
  final InternetConnectionStatus status;
  const InternetConnectionChanged(this.status);
}
