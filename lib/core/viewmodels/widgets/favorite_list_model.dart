import 'package:stacked/stacked.dart';

import '../../../config/locator.dart';
import '../../models/tvshow_actions.dart';
import '../../models/tvshow_details.dart';
import '../../services/app_service.dart';
import '../../services/favs_service.dart';

class FavoriteListModel extends StreamViewModel<List<TvshowDetails>> {
  final FavsService _favsService = locator<FavsService>();
  final AppService _appService = locator<AppService>();

  @override
  Stream<List<TvshowDetails>> get stream => _favsService.listFavs;

  Future<void> getFavs() async {
    setBusy(true);
    await _favsService.getFavs();
    setBusy(false);
  }

  Future<TvshowDetails> verifyAppLink() async {
    final TvshowActions tvshowActions = await _appService.initUniLinks();
    if (tvshowActions.tvshow.isEmpty ||
        isBusy ||
        data == null ||
        data.isEmpty ||
        _appService.timesOpenLink > 1) return TvshowDetails();
    return data.singleWhere(
      (TvshowDetails tvshowDetails) =>
          tvshowDetails.name.toLowerCase().contains(tvshowActions.tvshow),
      orElse: () => TvshowDetails(),
    );
  }
}
