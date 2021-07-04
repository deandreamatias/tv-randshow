import 'package:stacked/stacked.dart';

import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/hive_database_service.dart';

class SaveModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final HiveDatabaseService _databaseService = locator<HiveDatabaseService>();

  bool tvshowInDb = false;

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (tvshowDetails != null) {
      await _databaseService.saveTvshow(tvshowDetails);
      tvshowInDb = true;
      setBusy(false);
      return true;
    } else {
      tvshowInDb = false;
      setBusy(false);
      return false;
    }
  }

  Future<void> deleteFav(int id) async {
    setBusy(true);
    final List<TvshowDetails> _list = await _databaseService.getTvshows();
    final TvshowDetails tvshowDetails = _list
        .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
    await _databaseService.deleteTvshow(tvshowDetails.id);
    tvshowInDb = false;
    setBusy(false);
  }
}
