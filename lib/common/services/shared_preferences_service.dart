import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<SharedPreferences> get _localPrefs async => await _initPrefs();
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> _initPrefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<T?> read<T>({required String key}) async {
    final _prefs = await _localPrefs;
    switch (T) {
      case String:
        return (_prefs.getString(key) ?? '') as T;
      case int:
        return _prefs.getInt(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case List:
        return _prefs.getStringList(key) as T?;
      default:
        return _prefs.get(key) as T?;
    }
  }

  Future<bool> write<T>({required String key, required T value}) async {
    final _prefs = await _localPrefs;
    switch (T) {
      case String:
        value as String;
        return await _prefs.setString(key, value);
      case int:
        value as int;
        return await _prefs.setInt(key, value);
      case bool:
        value as bool;
        return _prefs.setBool(key, value);
      case double:
        value as double;
        return _prefs.setDouble(key, value);
      case List:
        value as List<String>;
        return _prefs.setStringList(key, value);
      default:
        log('$runtimeType: Error to save value');
        return false;
    }
  }
}
