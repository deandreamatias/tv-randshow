import 'package:flutter/widgets.dart';

import '../../../config/flavor_config.dart';
import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/database_service.dart';
import '../base_model.dart';

class SaveModel extends BaseModel {
  SaveModel({
    @required ApiService apiService,
    @required DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;
  final ApiService _apiService;
  final DatabaseService _databaseService;

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
      await _databaseService.insert(tvshowDetails);
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
    final List<TvshowDetails> _list = await _databaseService.queryList();
    final TvshowDetails tvshowDetails = _list
        .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
    await _databaseService.delete(tvshowDetails.rowId);
    tvshowInDb = false;
    setBusy(false);
  }
}
