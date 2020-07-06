import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../base_model.dart';

class RandomModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();

  Future<TvshowDetails> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    setBusy(false);
    return tvshowDetails;
  }
}
