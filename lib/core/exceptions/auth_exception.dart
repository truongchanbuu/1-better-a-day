import '../../generated/l10n.dart';

abstract class AuthFailure implements Exception {
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';
  static const String accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const String invalidCredential = 'invalid-credential';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String invalidVerificationId = 'invalid-verification-id';
  static const String userTokenExpired = 'user-token-expired';

  final String? code;
  final String message;

  const AuthFailure([
    this.code,
    this.message = 'An unknown exception occurred.',
  ]);
}

class SignUpWithEmailAndPasswordFailure extends AuthFailure {
  const SignUpWithEmailAndPasswordFailure([super.code, super.message]);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    return SignUpWithEmailAndPasswordFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogInWithEmailAndPasswordFailure extends AuthFailure {
  const LogInWithEmailAndPasswordFailure([super.code, super.message]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    return LogInWithEmailAndPasswordFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogInWithGoogleFailure extends AuthFailure {
  const LogInWithGoogleFailure([super.code, super.message]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    return LogInWithGoogleFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class UpdateAccountFailure extends AuthFailure {
  const UpdateAccountFailure([super.code, super.message]);

  factory UpdateAccountFailure.fromCode(String code) {
    return UpdateAccountFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogOutFailure extends AuthFailure {
  const LogOutFailure([super.message]);
}

class PasswordResetFailure extends AuthFailure {
  const PasswordResetFailure([super.code, super.message]);

  factory PasswordResetFailure.fromCode(String code) {
    return PasswordResetFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

final Map<String, String> _authErrorMessages = {
  AuthFailure.invalidEmail: S.current.invalid_email,
  AuthFailure.userDisabled: S.current.user_disabled,
  AuthFailure.emailAlreadyInUse: S.current.email_already_in_use,
  AuthFailure.operationNotAllowed: S.current.operation_not_allowed,
  AuthFailure.weakPassword: S.current.weak_password,
  AuthFailure.userNotFound: S.current.user_not_found,
  AuthFailure.wrongPassword: S.current.wrong_password,
  AuthFailure.accountExistsWithDifferentCredential:
      S.current.account_exists_with_different_credential,
  AuthFailure.invalidCredential: S.current.invalid_credential,
  AuthFailure.invalidVerificationCode: S.current.invalid_verification_code,
  AuthFailure.invalidVerificationId: S.current.invalid_verification_id,
};
