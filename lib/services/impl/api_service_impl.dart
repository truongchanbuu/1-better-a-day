import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/log/app_logger.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../core/resources/data_state.dart';
import '../api_service.dart';

class ApiServiceImpl<T> implements ApiService<T> {
  final AppLogger appLogger;
  final String collectionPath;
  final FirebaseFirestore firestore;
  final T Function(Map<String, dynamic> json) fromJson;

  ApiServiceImpl({
    required this.collectionPath,
    required this.firestore,
    required this.fromJson,
    required this.appLogger,
  });

  @override
  CollectionReference<Object?> get collection =>
      firestore.collection(collectionPath);

  DataFailure<E> _handleError<E>(Object e) {
    if (e is FirebaseException) {
      final errorMessages = {
        'permission-denied':
            'You don\'t have permission to perform this operation',
        'unauthenticated': 'Authentication is required for this operation',
        'not-found': 'The requested document was not found',
        'already-exists': 'Document already exists and cannot be overwritten',
        'failed-precondition':
            'Operation failed due to the current document state',
        'aborted': 'Operation was aborted due to a conflict',
        'unavailable':
            'Service is currently unavailable, please try again later',
        'deadline-exceeded': 'Operation timed out, please try again',
        'data-loss': 'Unrecoverable data loss or corruption occurred',
        'invalid-argument': 'Invalid data provided for this operation',
        'resource-exhausted':
            'Resource limits exceeded, please try again later',
        'out-of-range': 'Operation specified an invalid range',
        'unimplemented': 'Operation is not implemented or not supported',
        'cancelled': 'Operation was cancelled',
        'internal': 'An internal error occurred, please try again later',
      };

      final message = e.message ??
          errorMessages[e.code] ??
          'An unexpected Firebase error occurred';
      return DataFailure<E>(
          FirebaseException(message: message, code: e.code, plugin: e.plugin));
    }

    if (e is TimeoutException) {
      return DataFailure<E>(FirebaseException(
        message:
            'Operation timed out. Please check your connection and try again',
        code: 'timeout',
        plugin: 'app_timeout',
      ));
    }

    if (e is FormatException) {
      return DataFailure<E>(FirebaseException(
        message: 'Invalid data format received',
        code: 'format-error',
        plugin: 'app_format',
      ));
    }

    return DataFailure<E>(FirebaseException(
      message: 'An unexpected error occurred',
      code: 'unknown_error',
      plugin: 'app_error',
    ));
  }

  DataFailure<T> _handleNotFound(String id) {
    final String errorMessage = 'There is no document with id $id';
    appLogger.e(errorMessage);
    return _handleError(FirebaseException(
      code: FirebaseFailure.notFound,
      message: errorMessage,
      plugin: 'data_error',
    ));
  }

  DataFailure<T> _handleInvalidId() {
    const String errorMessage = 'ID cannot be empty';
    appLogger.e(errorMessage);
    return _handleError(FirebaseException(
      code: FirebaseFailure.invalidArgument,
      message: errorMessage,
      plugin: 'data_error',
    ));
  }

  @override
  Future<DataState<T>> createById({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    assert(id.isNotEmpty);
    if (id.isEmpty) {
      return _handleInvalidId();
    }

    try {
      data.addAll({'createdAt': DateTime.now().toIso8601String()});
      await collection.doc(id).set(data);

      final result = await getById(id: id);
      if (result.data is! T) {
        return _handleError(
            Exception('Failed to retrieve or cast the updated data'));
      }

      return DataSuccess(result.data as T);
    } catch (e) {
      appLogger.e(e);
      return _handleError(e);
    }
  }

  @override
  Future<DataState<T>> update({
    required String id,
    required Map<String, dynamic> updated,
  }) async {
    assert(id.isNotEmpty && updated.isNotEmpty);
    if (id.isEmpty) {
      return _handleInvalidId();
    }

    if (updated.isEmpty) {
      return _handleInvalidId();
    }

    updated.addAll({'updatedAt': DateTime.now().toIso8601String()});
    try {
      final docQuery = collection.doc(id);
      await docQuery.update(updated);

      final result = await getById(id: id);
      if (result.data is! T) {
        return _handleError(
            Exception('Failed to retrieve or cast the updated data'));
      }

      return DataSuccess(result.data as T);
    } catch (e) {
      appLogger.e(e);
      return _handleError(e);
    }
  }

  @override
  Future<DataState<T>> delete({required String id}) async {
    if (id.isEmpty) {
      return _handleInvalidId();
    }

    try {
      final docQuery = collection.doc(id);
      final docSnap = await docQuery.get();

      if (!docSnap.exists) {
        return _handleNotFound(id);
      }

      await docQuery.delete();
      return DataSuccess(fromJson(docSnap.data() as Map<String, dynamic>));
    } catch (e) {
      appLogger.e(e);
      return _handleError(e);
    }
  }

  @override
  Future<DataState<List<T>>> getAll({
    String? fieldPath,
    dynamic isEqualTo,
    dynamic isGreaterThan,
    dynamic isLessThan,
    int? limit,
    String? orderBy,
    bool? descending,
  }) async {
    try {
      Query<Object?> query = collection;

      if (fieldPath != null) {
        if (isEqualTo != null) {
          query = query.where(fieldPath, isEqualTo: isEqualTo);
        }
        if (isGreaterThan != null) {
          query = query.where(fieldPath, isGreaterThan: isGreaterThan);
        }
        if (isLessThan != null) {
          query = query.where(fieldPath, isLessThan: isLessThan);
        }
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending ?? false);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty) {
        return const DataSuccess([]);
      }

      final List<T> data = querySnapshot.docs
          .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return DataSuccess(data);
    } catch (e) {
      appLogger.e(e);
      return _handleError(e);
    }
  }

  @override
  Future<DataState<T>> getById({required String id}) async {
    assert(id.isNotEmpty);
    if (id.isEmpty) {
      return _handleInvalidId();
    }

    try {
      final docSnap = await collection.doc(id).get();

      if (!docSnap.exists) {
        return _handleNotFound(id);
      }

      final data = docSnap.data() as Map<String, dynamic>;
      return DataSuccess(fromJson(data));
    } catch (e) {
      appLogger.e(e);
      return _handleError(e);
    }
  }

  @override
  Stream<DataState<List<T>>> watchAll({
    String? fieldPath,
    isEqualTo,
    int? limit,
    DocumentSnapshot? lastDocument,
  }) {
    final queryLimit = limit ?? 20;
    try {
      Query<Object?> query = collection;

      if (fieldPath != null && isEqualTo != null) {
        query = query.where(fieldPath, isEqualTo: isEqualTo);
      }

      query = query.limit(queryLimit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      return query.snapshots().map((snap) {
        if (snap.docs.isEmpty) {
          return const DataSuccess([]);
        }

        final List<T> data = snap.docs
            .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return DataSuccess(data);
      });
    } catch (e) {
      appLogger.e(e);
      return Stream.error(_handleError(e));
    }
  }

  @override
  Stream<DataState<T>> watchById({required String id}) {
    try {
      return collection.doc(id).snapshots().map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return DataSuccess(fromJson(data));
      });
    } catch (e) {
      appLogger.e(e);
      return Stream.error(_handleError(e));
    }
  }
}
