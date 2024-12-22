import 'package:hive_ce/hive.dart';

import '../../core/resources/hive_base_model.dart';
import '../hive_crud_service.dart';

class HiveCRUDImplementation<T extends HiveBaseModel>
    implements HiveCRUDInterface<T> {
  final Box<Map<String, dynamic>> box;
  final T Function() createInstance;

  HiveCRUDImplementation(this.box, this.createInstance);

  @override
  Future<void> create(T item) async {
    await box.put(item.key, item.toMap());
  }

  @override
  Future<T?> read(dynamic key) async {
    final map = box.get(key);
    if (map == null) return null;

    final instance = createInstance();
    return instance.fromMap(Map<String, dynamic>.from(map));
  }

  @override
  Future<List<T>> readAll() async {
    return box.values.map((map) {
      final instance = createInstance();
      instance.fromMap(Map<String, dynamic>.from(map));
      return instance;
    }).toList();
  }

  @override
  Future<void> update(dynamic key, T item) async {
    await box.put(key, item.toMap());
  }

  @override
  Future<void> delete(dynamic key) async {
    await box.delete(key);
  }

  @override
  Future<void> deleteAll() async {
    await box.clear();
  }

  @override
  Future<List<T>> readAllByKey(key) async {
    return box.values.where((element) => element.keys.contains(key)).map((map) {
      final instance = createInstance();
      instance.fromMap(Map<String, dynamic>.from(map));
      return instance;
    }).toList();
  }
}
