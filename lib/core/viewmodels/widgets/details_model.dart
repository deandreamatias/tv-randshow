import 'package:stacked/stacked.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/api_service.dart';

class DetailsModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();

  TvshowDetails? tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    tvshowDetails = await _apiService.getDetailsTv(query, id);
    setBusy(false);
  }
}
