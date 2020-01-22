import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'log_service.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LogService _logService = LogService.instance;

  Future<void> writeStorage(String key, String value) async {
    await storage.write(key: key, value: value).then((void empty) {
      _logService.logger.i('Write token');
    }).catchError((dynamic onError) {
      _logService.logger.e('Write token', onError);
    });
  }

  Future<String> readStorage(String key) async {
    final String value = await storage.read(key: key).catchError(
        (dynamic onError) => _logService.logger.e('Write token', onError));
    return value;
  }

  Future<void> deleteStorage(String key) async {
    await storage.delete(key: key).then((void empty) {
      _logService.logger.i('Write token');
    }).catchError((dynamic onError) {
      _logService.logger.e('Write token', onError);
    });
  }
}
