import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future<void> writeStorage(String key, String value) async {
    await storage.write(key: key, value: value).then((empty) {
      print('-- Write token with success');
    }).catchError((dynamic onError) {
      print('-- Error: $onError to write token');
    });
  }

  Future<String> readStorage(String key) async {
    String value = await storage.read(key: key);
    return value;
  }

  Future<void> deleteStorage(String key) async {
    await storage.delete(key: key).then((empty) {
      print('-- Delete token with success');
    }).catchError((dynamic onError) {
      print('-- Error: $onError to delete token');
    });
  }
}
