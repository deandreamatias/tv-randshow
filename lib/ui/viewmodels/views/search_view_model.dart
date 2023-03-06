import 'dart:async';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:stacked/stacked.dart';

import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/search.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/search_tvshow_use_case.dart';

class SearchViewModel extends BaseViewModel {
  final SearchTvShowUseCase _searchTvShowUseCase =
      locator<SearchTvShowUseCase>();
  Timer? _timer;

  Timer? get timer => _timer;

  Future<List<Result>> loadList(String text, int page, String language) async {
    if (text.isNotEmpty) {
      final Query query = Query(
        language: language,
        page: page,
        query: text,
      );
      final Search search = await _searchTvShowUseCase(query);
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
