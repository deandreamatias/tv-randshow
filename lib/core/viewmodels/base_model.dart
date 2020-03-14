import 'package:flutter/widgets.dart';

import '../services/log_service.dart';

class BaseModel extends ChangeNotifier {
  final LogService _logger = LogService.instance;
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    _logger.logger.i('State busy: $_busy');
    notifyListeners();
  }
}
