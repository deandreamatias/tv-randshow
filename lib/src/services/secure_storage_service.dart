import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'log_service.dart';
import 'service_locator.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LogService _logger = locator<LogService>();

  Future<void> writeStorage(String key, String value) async {
    await storage.write(key: key, value: value).then((void empty) {
      _logger.printInfo('Write token');
    }).catchError((dynamic onError) {
      _logger.printError('Write token', onError);
    });
  }

  Future<String> readStorage(String key) async {
    final String value = await storage.read(key: key).catchError(
        (dynamic onError) => _logger.printError('Write token', onError));
    return value;
  }

  Future<void> deleteStorage(String key) async {
    await storage.delete(key: key).then((void empty) {
      _logger.printInfo('Write token');
    }).catchError((dynamic onError) {
      _logger.printError('Write token', onError);
    });
  }
}
