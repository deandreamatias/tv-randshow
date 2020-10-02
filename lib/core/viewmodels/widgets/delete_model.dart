import 'package:stacked/stacked.dart';

import '../../../config/locator.dart';
import '../../services/favs_service.dart';

class DeleteModel extends BaseViewModel {
  final FavsService _favsService = locator<FavsService>();

  Future<void> deleteFav(int id) async {
    await _favsService.deleteFav(id);
  }
}
