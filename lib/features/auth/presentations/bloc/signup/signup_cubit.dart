import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/exceptions/auth_exception.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit(this.authRepository) : super(const SignupInitial());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(EmailChanged(state, email));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(PasswordChanged(state, password));
  }

  Future<String?> signUpFormSubmitted() async {
    if (!state.isValid) return S.current.invalid_form;
    emit(SignUpInProgressing(state));
    try {
      await authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(SignUpSucceed(state));
      return null;
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(SignUpFailed(state, e.message));
      return e.message;
    }
  }
}
