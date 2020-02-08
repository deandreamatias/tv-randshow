import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/database_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class SaveModel extends BaseModel {
  // TODO: Test with attention this model
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

  bool tvshowInDb;
  TvshowDetails _tvshowDetails;
  List<TvshowDetails> _list;

  Future<void> getDatabaseInfo(int id) async {
    setBusy(true);
    _list = await _databaseService.queryList();
    // TODO: Monitor this process for each list item
    if (_list != null && _list.isNotEmpty) {
      _tvshowDetails = _list
          .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
      tvshowInDb = _tvshowDetails != null;
      _list.clear();
    } else {
      tvshowInDb = false;
    }
    setBusy(false);
  }

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
      language: language,
    );
    final TvshowDetails tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (tvshowDetails != null) {
      _databaseService.insert(tvshowDetails);
      setBusy(false);
      return true;
    } else {
      setBusy(false);
      return false;
    }
  }

  Future<void> deleteFav(int id) async {
    setBusy(true);
    await _databaseService.delete(id);
    setBusy(false);
  }
}
