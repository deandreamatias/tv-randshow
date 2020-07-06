import 'dart:developer';

import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    log('State busy: $_busy');
    notifyListeners();
  }
}
