import 'package:flutter/widgets.dart';

import '../../../config/flavor_config.dart';
import '../../models/query.dart';
import '../../models/result.dart';
import '../../models/search.dart';
import '../../services/api_service.dart';
import '../base_model.dart';

class SearchViewModel extends BaseModel {
  SearchViewModel({
    @required ApiService apiService,
  })  : _apiService = apiService;
  final ApiService _apiService;

  Future<List<Result>> loadList(String text, int page, String language) async {
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
      page: page,
      query: text,
    );
    final Search search = await _apiService.getSearch(query);
    if (search != null && search.results.isNotEmpty) {
      return search.results;
    } else {
      return null;
    }
  }
}
