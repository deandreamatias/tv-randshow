import 'package:stacked/stacked.dart';

import 'package:tv_randshow/core/app/domain/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/domain/models/tvshow_actions.dart';
import 'package:tv_randshow/core/app/domain/services/favs_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

class FavoriteListModel extends StreamViewModel<List<TvshowDetails>> {
  final FavsService _favsService = locator<FavsService>();
  final IAppService _appService = locator<IAppService>();

  @override
  Stream<List<TvshowDetails>> get stream => _favsService.listFavs;

  Future<void> getFavs() async {
    setBusy(true);
    await _favsService.getFavs();
    setBusy(false);
  }

  Future<TvshowDetails?> verifyAppLink() async {
    final TvshowActions tvshowActions = await _appService.initUniLinks();
    if (tvshowActions.tvshow.isEmpty ||
        isBusy ||
        data == null ||
        data!.isEmpty) {
      return null;
    }
    return data!.singleWhere(
      (TvshowDetails tvshowDetails) =>
          tvshowDetails.name.toLowerCase().contains(tvshowActions.tvshow),
    );
  }
}
