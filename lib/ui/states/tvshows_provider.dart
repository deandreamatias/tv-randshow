import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

class TvShowsNotifier extends AsyncNotifier<List<TvshowDetails>> {
  final GetLocalTvshowsUseCase _getLocalTvshowsUseCase =
      locator<GetLocalTvshowsUseCase>();
  @override
  FutureOr<List<TvshowDetails>> build() async {
    return await _getLocalTvshowsUseCase();
  }
}

final tvshowsProvider =
    AsyncNotifierProvider.autoDispose<TvShowsNotifier, List<TvshowDetails>>(
  TvShowsNotifier.new,
);
