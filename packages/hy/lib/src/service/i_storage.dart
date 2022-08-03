abstract class IStorage {
  Future<bool> put<T>(String key, T value);
  T? get<T>(String key, T transformer(dynamic map), {T? defValue});
  dynamic getJsonObject(String key);
  String? getString(String key, {String? defValue});
  Future<bool> putString(String key, String value);
  bool? getBool(String key, {bool? defValue});
  Future<bool> putBool(String key, bool value);
  int? getInt(String key, {int? defValue});
  Future<bool> putInt(String key, int value);
  double? getDouble(String key, {double? defValue});
  Future<bool> putDouble(String key, double value);
  List<String>? getStringList(String key, {List<String>? defValue = const []});
  Future<bool> putStringList(String key, List<String> value);
  bool haveKey(String key);
  Set<String> getKeys();
  Future<bool> remove(String key);
  Future<bool> clear();
}