import 'package:hive_ce/hive.dart';

import '../../config/log/app_logger.dart';
import '../../core/resources/hive_base_model.dart';
import '../../injection_container.dart';
import '../hive_crud_service.dart';

class HiveCRUDImplementation<T extends HiveBaseModel>
    implements HiveCRUDInterface<T> {
  final Box<Map<dynamic, dynamic>> box;
  final T Function() createInstance;

  HiveCRUDImplementation(this.box, this.createInstance);

  final _appLogger = getIt.get<AppLogger>();

  @override
  Future<void> create(T item) async {
    try {
      await box.put(item.key, item.toMap());
    } catch (e) {
      _appLogger.e("ReadAll error: $e");
    }
  }

  @override
  Future<T?> read(dynamic key) async {
    try {
      final map = box.get(key);
      if (map == null) return null;

      final instance = createInstance();
      return instance.fromMap(Map<String, dynamic>.from(map));
    } catch (e) {
      _appLogger.e("Read error: $e");
      rethrow;
    }
  }

  @override
  Future<List<T>> readAll() async {
    try {
      return box.values.map((map) {
        T instance = createInstance();
        instance = instance.fromMap(Map<String, dynamic>.from(map));
        return instance;
      }).toList();
    } catch (e) {
      _appLogger.e("ReadAll error: $e");
      return [];
    }
  }

  @override
  Future<List<T>> readAllByKey(key, value) async {
    try {
      return box.values.where((element) {
        return element[key] != null && element[key] == value;
      }).map((map) {
        T instance = createInstance();
        instance = instance.fromMap(Map.from(map));
        return instance;
      }).toList();
    } catch (e) {
      _appLogger.e("ReadAllByKey error: $e");
      return [];
    }
  }

  @override
  Future<void> update(dynamic key, T item) async {
    try {
      final existingValue = box.get(key);

      if (existingValue == null) {
        throw Exception('Not found');
      }

      await box.put(key, item.toMap());

      final updatedValue = box.get(key);
      if (updatedValue == null) {
        throw Exception('Update failed');
      }
    } catch (e) {
      _appLogger.e('Cannot update: $e');
    }
  }

  @override
  Future<void> delete(dynamic key) async {
    try {
      await box.delete(key);
    } catch (e) {
      _appLogger.e('Cannot delete: $e');
    }
  }

  @override
  Future<void> deleteAll() async {
    await box.clear();
  }
}
