import '../../generated/l10n.dart';

abstract class FirebaseFailure implements Exception {
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
  static const String notFound = 'not-found';
  static const String invalidArgument = 'invalid-argument';

  final String? code;
  final String message;

  const FirebaseFailure([
    this.code,
    this.message = 'An unknown exception occurred.',
  ]);
}

class SignUpWithEmailAndPasswordFailure extends FirebaseFailure {
  const SignUpWithEmailAndPasswordFailure([super.code, super.message]);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    return SignUpWithEmailAndPasswordFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogInWithEmailAndPasswordFailure extends FirebaseFailure {
  const LogInWithEmailAndPasswordFailure([super.code, super.message]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    return LogInWithEmailAndPasswordFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogInWithGoogleFailure extends FirebaseFailure {
  const LogInWithGoogleFailure([super.code, super.message]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    return LogInWithGoogleFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class UpdateAccountFailure extends FirebaseFailure {
  const UpdateAccountFailure([super.code, super.message]);

  factory UpdateAccountFailure.fromCode(String code) {
    return UpdateAccountFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class LogOutFailure extends FirebaseFailure {
  const LogOutFailure([super.message]);
}

class UpdateInfoFailure extends FirebaseFailure {
  const UpdateInfoFailure([super.code, super.message]);
  factory UpdateInfoFailure.fromCode(String code) {
    return UpdateInfoFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

class PasswordResetFailure extends FirebaseFailure {
  const PasswordResetFailure([super.code, super.message]);

  factory PasswordResetFailure.fromCode(String code) {
    return PasswordResetFailure(
      code,
      _authErrorMessages[code] ?? S.current.unknown_exception,
    );
  }
}

final Map<String, String> _authErrorMessages = {
  FirebaseFailure.invalidEmail: S.current.invalid_email,
  FirebaseFailure.userDisabled: S.current.user_disabled,
  FirebaseFailure.emailAlreadyInUse: S.current.email_already_in_use,
  FirebaseFailure.operationNotAllowed: S.current.operation_not_allowed,
  FirebaseFailure.weakPassword: S.current.weak_password,
  FirebaseFailure.userNotFound: S.current.user_not_found,
  FirebaseFailure.wrongPassword: S.current.wrong_password,
  FirebaseFailure.accountExistsWithDifferentCredential:
      S.current.account_exists_with_different_credential,
  FirebaseFailure.invalidCredential: S.current.invalid_credential,
  FirebaseFailure.invalidVerificationCode: S.current.invalid_verification_code,
  FirebaseFailure.invalidVerificationId: S.current.invalid_verification_id,
};
