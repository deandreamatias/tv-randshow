import 'package:stacked/stacked.dart';

import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';

class RandomModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();

  TvshowDetails _tvshowDetails;

  TvshowDetails get tvshowDetails => _tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    _tvshowDetails = await _apiService.getDetailsTv(query, id);
    setBusy(false);
  }
}
