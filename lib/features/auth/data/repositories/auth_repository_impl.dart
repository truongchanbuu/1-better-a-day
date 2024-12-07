import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../config/log/app_logger.dart';
import '../../../../core/constants/app_storage_key.dart';
import '../../../../core/helpers/cached_client.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user.dart';
import '../../../../core/exceptions/auth_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CacheClient cache;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserRepository userRepository;
  final AppLogger appLogger = getIt.get<AppLogger>();

  final _userController = StreamController<UserModel>();
  UserModel _cachedUser = UserModel.fromEntity(UserEntity.empty);

  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 1);

  AuthRepositoryImpl({
    required this.cache,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.userRepository,
  }) {
    _initUserStream();
  }

  void _initUserStream() {
    firebaseAuth.authStateChanges().listen(
          _handleAuthStateChange,
          onError: (error) => appLogger.e('Auth state change error: $error'),
        );
  }

  Future<void> _handleAuthStateChange(User? firebaseUser) async {
    if (firebaseUser == null) {
      await _handleNullUser();
      return;
    }

    await _processUserData(firebaseUser);
  }

  Future<void> _handleNullUser() async {
    await _updateCachedUser(UserModel.fromEntity(UserEntity.empty));
  }

  Future<void> _processUserData(User firebaseUser) async {
    try {
      final userFromAuth = firebaseUser.toUser;
      final userData = await _fetchUserData(firebaseUser.uid);
      if (userData == null) {
        await _handleNullUser();
        return;
      }

      final combinedUser = _combineUserData(userFromAuth, userData);
      await _updateCachedUser(UserModel.fromEntity(combinedUser));
    } catch (error) {
      appLogger.e('Failed to get user data from database: $error');
      await _updateCachedUser(UserModel.fromEntity(firebaseUser.toUser));
    }
  }

  Future<UserEntity?> _fetchUserData(String userId) async {
    final userDataState = await userRepository.getUserById(userId);
    return userDataState is DataSuccess ? userDataState.data : null;
  }

  UserEntity _combineUserData(UserEntity userFromAuth, UserEntity? userFromDB) {
    return userFromAuth.copyWith(
      gender: userFromDB?.gender ?? userFromAuth.gender,
      dateOfBirth: userFromDB?.dateOfBirth ?? userFromAuth.dateOfBirth,
      username: userFromDB?.username ?? userFromAuth.username,
      phoneNumber: userFromDB?.phoneNumber ?? userFromAuth.phoneNumber,
      avatarUrl: userFromDB?.avatarUrl ?? userFromAuth.avatarUrl,
    );
  }

  Future<void> _updateCachedUser(UserModel user) async {
    _cachedUser = user;
    await cache.setJson(AppStorageKey.appUserCachedKey, user.toJson());
    _userController.add(user);
  }

  @override
  Stream<UserModel> get user => _userController.stream;

  @override
  Future<UserModel> get currentUser async {
    if (_cachedUser != UserModel.fromEntity(UserEntity.empty)) {
      return _cachedUser;
    }

    try {
      final data = cache.getJson(AppStorageKey.appUserCachedKey);
      if (data != null) {
        _cachedUser = UserModel.fromJson(data);
        return _cachedUser;
      }

      if (firebaseAuth.currentUser != null) {
        _cachedUser = UserModel.fromEntity(firebaseAuth.currentUser!.toUser);
        await _updateCachedUser(_cachedUser);
        return _cachedUser;
      }
    } catch (error) {
      appLogger.e("Failed to get current user: $error");
    }

    return UserModel.fromEntity(UserEntity.empty);
  }

  @override
  Future<void> reload() => _retryOperation(
        firebaseAuth.currentUser!.reload,
        'reload user',
      );

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _retryOperation(
        () async {
          final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          await _updateCachedUser(
              UserModel.fromEntity(userCredential.user!.toUser));
        },
        'email login',
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      final userCredential = await (kIsWeb
          ? _handleWebGoogleSignIn()
          : _handleMobileGoogleSignIn());

      if (userCredential.user != null) {
        await addUserDatabase(userCredential.user!.toUser);
        await _updateCachedUser(
            UserModel.fromEntity(userCredential.user!.toUser));
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<UserCredential> _handleWebGoogleSignIn() async {
    final googleProvider = GoogleAuthProvider();
    final userCredential = await firebaseAuth.signInWithPopup(googleProvider);
    return userCredential;
  }

  Future<UserCredential> _handleMobileGoogleSignIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw const LogInWithGoogleFailure();

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _retryOperation(() async {
        final userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user!.toUser;
        await addUserDatabase(user);
        await _processUserData(userCredential.user!);
      }, 'sign up');
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await cache.remove(AppStorageKey.appUserCachedKey);
      _cachedUser = UserModel.fromEntity(UserEntity.empty);

      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);

      _userController.add(UserModel.fromEntity(UserEntity.empty));
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  Future<T> _retryOperation<T>(
    Future<T> Function() operation,
    String operationName, {
    int maxRetries = _maxRetries,
    Duration delay = _retryDelay,
  }) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        return await operation();
      } catch (e) {
        if (attempts >= maxRetries) {
          appLogger.e('Failed $operationName after $attempts attempts: $e');
          rethrow;
        }
        await Future.delayed(delay * attempts);
      }
    }
  }

  @override
  Future<void> reAuthWithEmail({required String password}) async {
    try {
      final email = firebaseAuth.currentUser?.email;
      if (email == null) {
        throw LogInWithEmailAndPasswordFailure.fromCode(
            FirebaseFailure.invalidEmail);
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await _retryOperation(
        () =>
            firebaseAuth.currentUser!.reauthenticateWithCredential(credential),
        're-authenticate',
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> reAuthWithGoogle() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw LogInWithGoogleFailure.fromCode(FirebaseFailure.userTokenExpired);
      }

      final isGoogleProvider = user.providerData
          .any((provider) => provider.providerId == 'google.com');
      if (!isGoogleProvider) {
        throw LogInWithGoogleFailure.fromCode(
            FirebaseFailure.invalidCredential);
      }

      final userCredential = await (kIsWeb
          ? _handleWebGoogleSignIn()
          : _handleMobileGoogleSignIn());

      final credential = userCredential.credential;
      if (credential == null) {
        throw LogInWithGoogleFailure.fromCode(
            FirebaseFailure.invalidCredential);
      }

      await _retryOperation(
        () =>
            firebaseAuth.currentUser!.reauthenticateWithCredential(credential),
        're-authenticate',
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<void> uploadPhotoUrl(String photoUrl) async => await _updateProfile(
      () => firebaseAuth.currentUser!.updatePhotoURL(photoUrl));

  @override
  Future<void> updateEmail(String email) async {
    await _updateProfile(
        () => firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email));
  }

  @override
  Future<void> updatePassword(String password) async => await _updateProfile(
      () => firebaseAuth.currentUser!.updatePassword(password));

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw PasswordResetFailure.fromCode(e.code);
    } catch (_) {
      throw const PasswordResetFailure();
    }
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw UpdateInfoFailure.fromCode(FirebaseFailure.invalidCredential);
      }

      await _updateProfile(
        () => firebaseAuth.currentUser!.updateDisplayName(displayName),
      );
      await userRepository.updateUserField(
        firebaseAuth.currentUser!.uid,
        {UserEntity.usernameFieldName: displayName},
      );
      await _updateCachedUser(
          UserModel.fromEntity(firebaseAuth.currentUser!.toUser));
    } on FirebaseAuthException catch (e) {
      throw UpdateInfoFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateInfoFailure();
    }
  }

  @override
  Future<void> updateGender(String gender) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw UpdateInfoFailure.fromCode(FirebaseFailure.invalidCredential);
      }

      await _updateProfile(() => userRepository.updateUserField(
            firebaseAuth.currentUser!.uid,
            {UserEntity.genderFieldName: gender},
          ));
      await _processUserData(firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw UpdateInfoFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateInfoFailure();
    }
  }

  @override
  Future<void> updateBirthDate(DateTime birthDate) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw UpdateInfoFailure.fromCode(FirebaseFailure.invalidCredential);
      }

      await _updateProfile(() => userRepository.updateUserField(
            firebaseAuth.currentUser!.uid,
            {UserEntity.dateOfBirthFieldName: birthDate.toIso8601String()},
          ));
      await _processUserData(firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw UpdateInfoFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateInfoFailure();
    }
  }

  @override
  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw UpdateInfoFailure.fromCode(FirebaseFailure.invalidCredential);
      }

      await _updateProfile(() => userRepository.updateUserField(
            firebaseAuth.currentUser!.uid,
            {UserEntity.phoneNumberFieldName: phoneNumber},
          ));
      await _processUserData(firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw UpdateInfoFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateInfoFailure();
    }
  }

  @override
  Future<void> updatePhotoUrl(String photoUrl) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw UpdateInfoFailure.fromCode(FirebaseFailure.invalidCredential);
      }
      await _updateProfile(() => userRepository.updateUserField(
            firebaseAuth.currentUser!.uid,
            {UserEntity.avatarUrlFieldName: photoUrl},
          ));
      await _processUserData(firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw UpdateInfoFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateInfoFailure();
    }
  }

  Future<void> _updateProfile(Future<void> Function() updateFn) async {
    try {
      await _retryOperation(updateFn, 'update profile');
    } on FirebaseAuthException catch (e) {
      throw UpdateAccountFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateAccountFailure();
    }
  }

  Future<void> addUserDatabase(UserEntity user) async {
    final existedUserDataState =
        await userRepository.getUserByEmail(user.email!);

    if (existedUserDataState is! DataSuccess) {
      await userRepository.createUser(UserModel.fromEntity(user));
    } else {
      final existedUser = existedUserDataState.data!;
      if (user.id != existedUser.id) {
        await userRepository.deleteUser(existedUser.id);
        await userRepository.createUser(UserModel.fromEntity(user));
      }
    }
  }

  @override
  void dispose() {
    _userController.close();
  }
}

extension on User {
  UserEntity get toUser {
    return UserEntity(
      id: uid,
      email: email,
      avatarUrl: photoURL,
      username: displayName,
      phoneNumber: phoneNumber,
      provider:
          providerData.isNotEmpty ? providerData.first.providerId : 'password',
    );
  }
}
