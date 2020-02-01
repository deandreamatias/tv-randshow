import 'package:flutter/widgets.dart';

import '../../services/database_service.dart';
import '../base_model.dart';

class DeleteModel extends BaseModel {
  DeleteModel({@required DatabaseService databaseService})
      : _databaseService = databaseService;
  final DatabaseService _databaseService;

  Future<void> deleteFav(int id) async {
    setBusy(true);
    await _databaseService.delete(id);
    setBusy(false);
  }
}
