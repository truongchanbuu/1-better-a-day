abstract class HiveBaseModel<T> {
  dynamic get key;
  Map<String, dynamic> toMap();
  T fromMap(Map<String, dynamic> map);
}
