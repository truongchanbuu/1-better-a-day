import 'package:formz/formz.dart';

import '../../../../generated/l10n.dart';

enum PasswordValidationError {
  invalid,
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return (value?.length ?? 0) >= 6 ? null : PasswordValidationError.invalid;
  }

  static String? validate(String? value) {
    if (value?.isEmpty ?? true) {
      return S.current.empty_field;
    }

    if (!passwordRegExp.hasMatch(value!)) {
      return S.current.invalid_password;
    }

    return null;
  }
}
