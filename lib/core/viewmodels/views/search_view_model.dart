import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../config/flavor_config.dart';
import '../../../config/locator.dart';
import '../../../ui/widgets/page_pagination.dart';
import '../../models/query.dart';
import '../../models/result.dart';
import '../../models/search.dart';
import '../../services/api_service.dart';

class SearchViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  Timer _timer;

  Timer get timer => _timer;

  Future<List<Result>> loadList(String text, int page, String language) async {
    if (text != null && text.isNotEmpty) {
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
    } else {
      return null;
    }
  }

  void searchAutomatic(PagewiseLoadController<Result> pageLoadController) {
    if (_timer != null && _timer.isActive) _timer.cancel();

    _timer =
        Timer(const Duration(seconds: 3), () => pageLoadController.reset());
  }
}
