import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../base_model.dart';

class DetailsModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();

  TvshowDetails tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails _tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (_tvshowDetails != null) {
      tvshowDetails = _tvshowDetails;
      setBusy(false);
    } else {
      setBusy(false);
    }
  }
}
