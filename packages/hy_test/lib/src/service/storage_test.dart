import 'dart:convert';

import 'package:hy/hy.dart';

class StorageTest extends IStorage {

  final storage = Map<String, dynamic>();

  @override
  Future<bool> clear() async {
    storage.clear();
    return true;
  }

  @override
  T? get<T>(String key, T Function(Map map) transformer, {T? defValue}) {
    final map = getJsonObject(key);
    return map == null ? defValue : transformer(map);
  }

  @override
  bool? getBool(String key, {bool? defValue}) =>
      storage.containsKey(key) ? storage[key] : defValue;

  @override
  double? getDouble(String key, {double? defValue}) =>
      storage.containsKey(key) ? storage[key] : defValue;

  @override
  int? getInt(String key, {int? defValue}) =>
      storage.containsKey(key) ? storage[key] : defValue;

  @override
  Set<String> getKeys() {
    return storage.keys.toSet();
  }

  @override
  String? getString(String key, {String? defValue}) =>
      storage.containsKey(key) ? storage[key] : defValue;

  @override
  List<String>? getStringList(String key, {List<String>? defValue = const []}) =>
      storage.containsKey(key) ? storage[key] : defValue;

  @override
  bool haveKey(String key) => storage.containsKey(key);

  @override
  Future<bool> put<T>(String key, T value) async {
    final storageValue = value == null ? null : json.encode(value);
    storage[key] = storageValue;
    return true;
  }

  @override
  Future<bool> putBool(String key, bool value) async {
    storage[key] = value;
    return true;
  }

  @override
  Future<bool> putDouble(String key, double value) async {
    storage[key] = value;
    return true;
  }

  @override
  Future<bool> putString(String key, String value) async {
    storage[key] = value;
    return true;
  }

  @override
  Future<bool> putStringList(String key, List<String> value) async {
    storage[key] = value;
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    storage.remove(key);
    return true;
  }

  @override
  Future<bool> putInt(String key, int value) async {
    storage[key] = value;
    return true;
  }

  @override
  dynamic getJsonObject(String key) {
    final data = getString(key);
    return data != null && data.isNotEmpty ? json.decode(data) : null;
  }
}