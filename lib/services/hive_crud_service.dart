abstract interface class HiveCRUDInterface<T> {
  Future<void> create(T item);
  Future<T?> read(dynamic key);
  Future<List<T>> readAll();
  Future<List<T>> readAllByKey(dynamic key, dynamic value);
  Future<void> update(dynamic key, T item);
  Future<void> delete(dynamic key);
  Future<void> deleteAll();
}
