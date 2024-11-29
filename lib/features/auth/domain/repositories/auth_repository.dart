import '../../data/models/user.dart';

abstract interface class AuthRepository {
  Stream<UserModel> get user;
  Future<UserModel> get currentUser;
  Future<void> reload();

  Future<void> signUp({
    required String email,
    required String password,
  });
  Future<void> logInWithGoogle();
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> reAuthWithEmail({required String password});
  Future<void> reAuthWithGoogle();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> uploadPhotoUrl(String photoUrl);
  Future<void> updateEmail(String email);
  Future<void> updatePassword(String password);
  Future<void> updateDisplayName(String displayName);
  Future<void> updateGender(String gender);
  Future<void> updateBirthDate(DateTime birthDate);
  Future<void> updatePhoneNumber(String phoneNumber);

  void dispose();
}
