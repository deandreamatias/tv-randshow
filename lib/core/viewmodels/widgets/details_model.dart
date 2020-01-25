import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class DetailsModel extends BaseModel {
  DetailsModel({
    @required ApiService apiService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  TvshowDetails tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
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
