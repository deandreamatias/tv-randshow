import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  Future<String> readStorage(String key) async {
    String value = await storage.read(key: key);
    return value;
  }

  deleteStorage(String key) async {
    await storage.delete(key: key);
  }

  writeStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
