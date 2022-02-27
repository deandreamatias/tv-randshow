import 'package:stacked/stacked.dart';

import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../streaming/domain/models/streaming_search.dart';
import '../../streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';

class DetailsModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final GetTvshowStreamingsUseCase _getTvshowStreamingsUseCase =
      locator<GetTvshowStreamingsUseCase>();

  TvshowDetails? tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails _tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    tvshowDetails = _tvshowDetails;
    await _getTvshowStreamingsUseCase(
      StreamingSearch(
        tmdbId: _tvshowDetails.id.toString(),
        country: 'es',
      ),
    );
    setBusy(false);
  }
}
