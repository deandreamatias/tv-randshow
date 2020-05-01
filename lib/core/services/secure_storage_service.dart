import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/flavor_config.dart';
import 'log_service.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LogService _logService = LogService.instance;

  Future<void> writeStorage(String key, String value) async {
    await storage.write(key: key, value: value).then((void empty) {
      _logService.logger.i('Write token');
    }).catchError((dynamic onError) {
      _logService.logger.e('Error to write token', onError);
    });
  }

  Future<String> readStorage(String key) async {
    if (!kIsWeb) {
      final String value = await storage.read(key: key).catchError(
          (dynamic onError) =>
              _logService.logger.e('Error to read token', onError));
      return value;
    } else {
      return FlavorConfig.instance.values.apiKey;
    }
  }

  Future<void> deleteStorage(String key) async {
    await storage.delete(key: key).then((void empty) {
      _logService.logger.i('Token deleted');
    }).catchError((dynamic onError) {
      _logService.logger.e('Error to delete token', onError);
    });
  }
}
