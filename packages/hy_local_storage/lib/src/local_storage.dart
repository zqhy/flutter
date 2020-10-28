import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:hy_flutter/hy_flutter.dart';


// https://github.com/Sky24n/flustars/blob/master/lib/src/sp_util.dart
class LocalStorage extends ILocalStorage {
  static LocalStorage _singleton;
  static SharedPreferences _sharedPreferences;

  static Future<LocalStorage> init() async {
    if (_singleton == null) {
      var singleton = LocalStorage._();
      await singleton._init();
      _singleton = singleton;
    }
    return _singleton;
  }

  LocalStorage._();

  static LocalStorage getInstance() => _singleton;

  Future _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  T get<T>(String key, T transformer(Map map), {T defValue}) {
    Map map = getObject(key);
    return map == null ? defValue : transformer(map);
  }

  @override
  Map getObject(String key) {
    if (_sharedPreferences == null) return null;
    String data = _sharedPreferences.getString(key);
    return data?.isNotEmpty == true ? json.decode(data) : null;
  }

  @override
  Future<bool> put<T>(String key, T value) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.setString(key, value == null ? null : json.encode(value));
  }

  @override
  String getString(String key, {String defValue}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.getString(key) ?? defValue;
  }

  @override
  Future<bool> putString(String key, String value) {
    if (_sharedPreferences == null ) return null;
    return _sharedPreferences.setString(key, value);
  }

  @override
  bool getBool(String key, {bool defValue}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.getBool(key) ?? defValue;
  }

  @override
  Future<bool> putBool(String key, bool value) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.setBool(key, value);
  }

  @override
  int getInt(String key, {int defValue}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.getInt(key) ?? defValue;
  }
  
  Future<bool> putInt(String key, int value) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.setInt(key, value);
  }

  @override
  double getDouble(String key, {double defValue}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.getDouble(key) ?? defValue;
  }

  @override
  Future<bool> putDouble(String key, double value) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.setDouble(key, value);
  }

  @override
  List<String> getStringList(String key, {List<String> defValue = const []}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.getStringList(key) ?? defValue;
  }

  @override
  Future<bool> putStringList(String key, List<String> value) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.setStringList(key, value);
  }

  @override
  dynamic getDynamic(String key, {Object defValue}) {
    if (_sharedPreferences == null) return defValue;
    return _sharedPreferences.get(key) ?? defValue;
  }

  @override
  bool haveKey(String key) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.getKeys().contains(key);
  }

  @override
  Set<String> getKeys() {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.getKeys();
  }

  @override
  Future<bool> remove(String key) {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.remove(key);
  }

  @override
  Future<bool> clear() {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.clear();
  }
}