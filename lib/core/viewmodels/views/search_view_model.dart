import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/result.dart';
import '../../models/search.dart';
import '../../services/api_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class SearchViewModel extends BaseModel {
  SearchViewModel({
    @required ApiService apiService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  bool searched = false;

  void getSearch() {
    setBusy(true);
    searched = true;
    setBusy(false);
  }

  void onSearch() {
    setBusy(true);
    searched = false;
    setBusy(false);
  }

  Future<List<Result>> loadList(String text, int page, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
      language: language,
      page: page,
      query: text,
    );
    final Search search = await _apiService.getSearch(query);
    if (search != null && search.results.isNotEmpty) {
      setBusy(false);
      return search.results;
    } else {
      setBusy(false);
      return null;
    }
  }
}
