import 'package:stacked/stacked.dart';

import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/app/domain/services/favs_service.dart';

class SaveModel extends BaseViewModel {
  final FavsService _favsService = locator<FavsService>();

  bool tvshowInDb = false;

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    try {
      await _favsService.addFav(id, language);
      tvshowInDb = true;
      setBusy(false);
      return true;
    } catch (e) {
      setBusy(false);
      return false;
    }
  }

  Future<void> deleteFav(int id) async {
    setBusy(true);
    await _favsService.deleteFav(id);
    tvshowInDb = false;
    setBusy(false);
  }
}
