import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_randshow/common/interfaces/local_preferences_service.dart';

class SharedPreferencesService implements ILocalPreferencesService {
  Future<SharedPreferences> get _localPrefs async => _initPrefs();
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> _initPrefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  @override
  Future<T?> read<T>({required String key}) async {
    final prefs = await _localPrefs;
    if (!prefs.containsKey(key)) return null;
    switch (T) {
      case String:
        return (prefs.getString(key) ?? '') as T;
      case int:
        return prefs.getInt(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case List:
        return prefs.getStringList(key) as T?;
      default:
        return prefs.get(key) as T?;
    }
  }

  @override
  Future<bool> write<T>({required String key, required T value}) async {
    final prefs = await _localPrefs;
    switch (T) {
      case String:
        value as String;
        return prefs.setString(key, value);
      case int:
        value as int;
        return prefs.setInt(key, value);
      case bool:
        value as bool;
        return prefs.setBool(key, value);
      case double:
        value as double;
        return prefs.setDouble(key, value);
      case List:
        value as List<String>;
        return prefs.setStringList(key, value);
      default:
        log('$runtimeType: Error to save value');
        return false;
    }
  }
}
