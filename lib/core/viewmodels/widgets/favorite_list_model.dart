import 'package:stacked/stacked.dart';

import '../../../config/locator.dart';
import '../../models/tvshow_details.dart';
import '../../services/favs_service.dart';

class FavoriteListModel extends StreamViewModel<List<TvshowDetails>> {
  final FavsService _favsService = locator<FavsService>();

  @override
  Stream<List<TvshowDetails>> get stream => _favsService.listFavs;

  Future<void> getFavs() async {
    setBusy(true);
    await _favsService.getFavs();
    setBusy(false);
  }
}
