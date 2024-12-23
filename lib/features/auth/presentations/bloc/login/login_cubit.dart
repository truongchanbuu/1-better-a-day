import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/exceptions/auth_exception.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(const LoginInitial());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(EmailChanged(state, email));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(PasswordChanged(state, password));
  }

  Future<String?> logInWithGoogle() async {
    emit(LoginInProgressing(state));
    try {
      await authRepository.logInWithGoogle();
      emit(LoginSucceed(state));
      return null;
    } on LogInWithGoogleFailure catch (e) {
      emit(LoginFailed(state, e.message));
    } catch (_) {
      emit(LoginFailed(state));
    }

    return state.errorMessage;
  }

  Future<String?> logInWithCredentials() async {
    if (state.isValid) {
      emit(LoginInProgressing(state));
      try {
        await authRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );

        emit(LoginSucceed(state));
        return null;
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(LoginFailed(state, e.message));
        return e.message;
      }
    }

    return S.current.invalid_form;
  }

  Future<String?> resetPassword(String email) async {
    try {
      await authRepository.sendPasswordResetEmail(email);
      return null;
    } on PasswordResetFailure catch (e) {
      return e.message;
    }
  }

  Future<void> reAuthWithGoogle() async {
    try {
      await authRepository.reAuthWithGoogle();
      emit(LoginSucceed(state));
    } on LogInWithGoogleFailure catch (e) {
      emit(LoginFailed(state, e.message));
    }
  }

  Future<void> reAuthWithEmail(String password) async {
    emit(LoginInProgressing(state));
    try {
      await authRepository.reAuthWithEmail(password: password);
      emit(LoginSucceed(state));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(LoginFailed(state, e.message));
    }
  }
}
