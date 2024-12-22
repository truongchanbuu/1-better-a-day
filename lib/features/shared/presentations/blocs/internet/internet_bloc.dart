import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../injection_container.dart';
part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final connectionChecker = InternetConnectionChecker.instance;
  final appLogger = getIt.get<AppLogger>();

  InternetBloc() : super(InternetInitial()) {
    on<CheckInternetConnection>(_checkInternetConnection);
    on<InternetConnectionChanged>(_onInternetConnectionChanged);
  }

  Future<void> _checkInternetConnection(
    CheckInternetConnection event,
    Emitter<InternetState> emit,
  ) async {
    emit(InternetLoading());
    try {
      final isConnected = await connectionChecker.hasConnection;
      if (isConnected) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
    } catch (e) {
      appLogger.e(e);
      emit(InternetDisconnected());
    }
  }

  Future<void> _onInternetConnectionChanged(
    InternetConnectionChanged event,
    Emitter<InternetState> emit,
  ) async =>
      await emit.onEach(
        connectionChecker.onStatusChange,
        onData: (status) {
          if (status == InternetConnectionStatus.connected) {
            emit(InternetConnected());
          } else {
            emit(InternetDisconnected());
          }
        },
        onError: (error, stackTrace) {
          appLogger.e(error);
          emit(InternetDisconnected());
        },
      );

  @override
  Future<void> close() {
    connectionChecker.dispose();
    return super.close();
  }
}
