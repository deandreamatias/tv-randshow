import 'package:stacked/stacked.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_fav_tvshow_use_case.dart';
import 'package:tv_randshow/ui/viewmodels/services/favs_service.dart';

class SaveModel extends BaseViewModel {
  final AddFavTvshowUseCase _addFavTvshow = locator<AddFavTvshowUseCase>();
  final FavsService _favsService = locator<FavsService>();

  bool tvshowInDb = false;

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    try {
      await _addFavTvshow(idTv: id, language: language);
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
