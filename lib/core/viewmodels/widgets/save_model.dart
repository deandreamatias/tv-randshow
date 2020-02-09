import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/database_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class SaveModel extends BaseModel {
  SaveModel({
    @required ApiService apiService,
    @required DatabaseService databaseService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _databaseService = databaseService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final DatabaseService _databaseService;
  final SecureStorageService _secureStorageService;

  bool tvshowInDb = false;

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
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
