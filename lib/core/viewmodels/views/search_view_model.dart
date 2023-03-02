import 'dart:async';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:stacked/stacked.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/result.dart';
import 'package:tv_randshow/core/models/search.dart';
import 'package:tv_randshow/core/services/api_service.dart';

class SearchViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  Timer? _timer;

  Timer? get timer => _timer;

  Future<List<Result>> loadList(String text, int page, String language) async {
    if (text.isNotEmpty) {
      final Query query = Query(
        apiKey: FlavorConfig.instance.values.apiKey,
        language: language,
        page: page,
        query: text,
      );
      final Search search = await _apiService.getSearch(query);
      if (search.results.isNotEmpty) {
        return search.results;
      }
    }
    return [];
  }

  void searchAutomatic(PagewiseLoadController<Result>? pageLoadController) {
    if (pageLoadController == null) return;

    if (_timer != null && (_timer?.isActive ?? false)) _timer!.cancel();

    _timer =
        Timer(const Duration(seconds: 3), () => pageLoadController.reset());
  }
}
