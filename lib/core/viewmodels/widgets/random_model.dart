import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class RandomModel extends BaseModel {
  RandomModel({
    @required ApiService apiService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  Future<TvshowDetails> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
      language: language,
    );
    final TvshowDetails tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    setBusy(false);
    return tvshowDetails;
  }
}
