import 'package:stacked/stacked.dart';

import '../../../config/locator.dart';
import '../../services/favs_service.dart';

class SaveModel extends BaseViewModel {
  final FavsService _favsService = locator<FavsService>();

  bool tvshowInDb = false;

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    final result = await _favsService.addFav(id, language);
    tvshowInDb = result;
    setBusy(false);
    return result;
  }

  Future<void> deleteFav(int id) async {
    setBusy(true);
    await _favsService.deleteFav(id);
    tvshowInDb = false;
    setBusy(false);
  }
}
