import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../config/log/app_logger.dart';
import '../../../../core/constants/app_storage_key.dart';
import '../../../../core/helpers/cached_client.dart';
import '../../../../core/resources/data_state.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user.dart';
import '../../../../core/exceptions/auth_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppLogger appLogger;
  final CacheClient cache;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserRepository userRepository;

  final _userController = StreamController<UserModel>();
  UserModel? _cachedUser;

  static const int _maxRetries = 5;
  static const Duration _retryDelay = Duration(seconds: 1);

  AuthRepositoryImpl({
    required this.cache,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.userRepository,
    required this.appLogger,
  }) {
    _initUserStream();
  }

  void _initUserStream() {
    firebaseAuth.authStateChanges().listen((firebaseUser) {
      final user = firebaseUser == null
          ? UserModel.fromEntity(UserEntity.empty)
          : UserModel.fromEntity(firebaseUser.toUser);

      _updateCachedUser(user);
    }, onError: (error) {
      appLogger.e('Auth state change error: $error');
    });
  }

  Future<void> _updateCachedUser(UserModel user) async {
    _cachedUser = user;
    await cache.setJson(AppStorageKey.appUserCachedKey, user.toJson());
    _userController.add(user);
  }

  @override
  Stream<UserModel> get user => _userController.stream;

  @override
  UserModel get currentUser {
    if (_cachedUser != null) return _cachedUser!;

    try {
      final data = cache.getJson(AppStorageKey.appUserCachedKey);
      if (data != null) {
        _cachedUser = UserModel.fromJson(data);
        return _cachedUser!;
      }

      if (firebaseAuth.currentUser != null) {
        _cachedUser = UserModel.fromEntity(firebaseAuth.currentUser!.toUser);
        _updateCachedUser(_cachedUser!);
        return _cachedUser!;
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
      if (kIsWeb) {
        await _handleWebGoogleSignIn();
      } else {
        await _handleMobileGoogleSignIn();
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> _handleWebGoogleSignIn() async {
    final googleProvider = GoogleAuthProvider();
    final userCredential = await firebaseAuth.signInWithPopup(googleProvider);

    if (userCredential.credential != null) {
      await firebaseAuth.signInWithCredential(userCredential.credential!);
      await addUserDatabase(userCredential.user!.toUser);
    }
  }

  Future<void> _handleMobileGoogleSignIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw const LogInWithGoogleFailure();

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await firebaseAuth.signInWithCredential(credential);
    await addUserDatabase(googleUser.toUser);
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
        final dataState =
            await userRepository.createUser(UserModel.fromEntity(user));

        if (dataState is DataFailure) {
          throw const SignUpWithEmailAndPasswordFailure();
        }

        await _updateCachedUser(UserModel.fromEntity(user));
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
      _cachedUser = null;

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
  Future<void> reAuthenticate({
    required String email,
    required String password,
  }) async {
    try {
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
  Future<void> uploadPhotoUrl(String photoUrl) =>
      _updateProfile(() => firebaseAuth.currentUser!.updatePhotoURL(photoUrl));

  @override
  Future<void> updateEmail(String email) => _updateProfile(
      () => firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email));

  @override
  Future<void> updatePassword(String password) =>
      _updateProfile(() => firebaseAuth.currentUser!.updatePassword(password));

  Future<void> _updateProfile(Future<void> Function() updateFn) async {
    try {
      await _retryOperation(updateFn, 'update profile');
    } on FirebaseAuthException catch (e) {
      throw UpdateAccountFailure.fromCode(e.code);
    } catch (_) {
      throw const UpdateAccountFailure();
    }
  }

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

  void dispose() {
    _userController.close();
  }

  Future<void> addUserDatabase(UserEntity user) async {
    final existedUserDataState =
        await userRepository.getUserByEmail(user.email!);
    if (existedUserDataState is! DataSuccess) {
      await userRepository.createUser(UserModel.fromEntity(user));
    }
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
    );
  }
}

extension on GoogleSignInAccount {
  UserEntity get toUser {
    return UserEntity(
      id: id,
      email: email,
      avatarUrl: photoUrl,
      username: displayName,
    );
  }
}
