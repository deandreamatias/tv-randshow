import '../../../config/locator.dart';
import '../../services/database_service.dart';
import '../base_model.dart';

class DeleteModel extends BaseModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<void> deleteFav(int id) async {
    await _databaseService.delete(id);
  }
}
