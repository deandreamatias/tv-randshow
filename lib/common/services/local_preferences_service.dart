import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_randshow/common/interfaces/i_local_preferences_service.dart';

class LocalPreferencesService implements ILocalPreferencesService {
  late SharedPreferences _sharedPreferences;
  LocalPreferencesService() {
    _initPrefs();
  }

  @override
  Future<T?> read<T>({required String key}) async {
    if (!_sharedPreferences.containsKey(key)) return null;
    switch (T) {
      case String:
        return (_sharedPreferences.getString(key) ?? '') as T;
      case int:
        return _sharedPreferences.getInt(key) as T?;
      case bool:
        return _sharedPreferences.getBool(key) as T?;
      case double:
        return _sharedPreferences.getDouble(key) as T?;
      case List:
        return _sharedPreferences.getStringList(key) as T?;
      default:
        return _sharedPreferences.get(key) as T?;
    }
  }

  @override
  Future<bool> write<T>({required String key, required T value}) async {
    switch (T) {
      case String:
        value as String;
        return _sharedPreferences.setString(key, value);
      case int:
        value as int;
        return _sharedPreferences.setInt(key, value);
      case bool:
        value as bool;
        return _sharedPreferences.setBool(key, value);
      case double:
        value as double;
        return _sharedPreferences.setDouble(key, value);
      case List:
        value as List<String>;
        return _sharedPreferences.setStringList(key, value);
      default:
        log('$runtimeType: Error to save value');
        return false;
    }
  }

  Future<void> _initPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
