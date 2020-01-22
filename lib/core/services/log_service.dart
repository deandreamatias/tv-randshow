import 'package:logger/logger.dart';

class LogService {
  LogService._internal();

  // make this a singleton class
  static final LogService instance = LogService._internal();

  // only have a single app-wide reference to the database
  static Logger _logger;
  Logger get logger {
    if (_logger != null) return _logger;

    _logger = Logger(
        printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 4,
      colors: true,
      printEmojis: true,
      printTime: true,
    ));

    return _logger;
  }
}
