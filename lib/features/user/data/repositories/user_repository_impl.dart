import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/auth_exception.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../services/api_service.dart';
import '../../../auth/data/models/user.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  static const int documentLimit = 20;
  final ApiService<UserModel> apiService;

  const UserRepositoryImpl(this.apiService);

  @override
  Future<DataState<UserModel>> createUser(UserModel user) async {
    return await apiService.createById(id: user.id, data: user.toJson());
  }

  @override
  Future<DataState<UserModel>> deleteUser(String userId) async {
    return await apiService.delete(id: userId);
  }

  @override
  Future<DataState<List<UserModel>>> getAllUsers({
    int limit = documentLimit,
    bool? desc,
    String? field,
    dynamic isEqualTo,
    dynamic isGreaterThan,
    dynamic isLessThan,
    String? orderBy,
  }) async {
    return await apiService.getAll(
      limit: limit,
      descending: desc,
      fieldPath: field,
      isEqualTo: isEqualTo,
      isGreaterThan: isGreaterThan,
      isLessThan: isLessThan,
      orderBy: orderBy,
    );
  }

  @override
  Future<DataState<UserModel>> getUserByEmail(String email) async {
    final dataState = await apiService.getAll(
        fieldPath: UserEntity.emailFieldName, isEqualTo: email);

    if (dataState is! DataFailure && (dataState.data?.isNotEmpty ?? false)) {
      return DataSuccess(dataState.data!.first);
    }

    return DataFailure(FirebaseException(
      code: FirebaseFailure.userNotFound,
      plugin: 'user',
      message: 'Not found',
    ));
  }

  @override
  Future<DataState<UserModel>> getUserById(String userId) async {
    return await apiService.getById(id: userId);
  }

  @override
  Stream<DataState<UserModel?>> streamUser(String userId) {
    return apiService.watchById(id: userId);
  }

  @override
  Future<DataState<UserModel>> updateUser(UserModel user) async {
    return await apiService.update(id: user.id, updated: user.toJson());
  }

  @override
  Future<DataState<UserModel>> updateUserField(
      String userId, Map<String, dynamic> fields) async {
    return await apiService.update(id: userId, updated: fields);
  }
}
