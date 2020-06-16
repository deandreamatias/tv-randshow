import 'package:flutter/widgets.dart';

import '../../../config/flavor_config.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../base_model.dart';

class RandomModel extends BaseModel {
  RandomModel({
    @required ApiService apiService,
  })  : _apiService = apiService;
  final ApiService _apiService;

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
