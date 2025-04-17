import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

class FavTvshowsNotifier extends AsyncNotifier<List<TvshowDetails>> {
  final GetLocalTvshowsUseCase _getLocalTvshows =
      locator<GetLocalTvshowsUseCase>();
  @override
  FutureOr<List<TvshowDetails>> build() async {
    return await _getLocalTvshows();
  }

  void addFav(TvshowDetails tvshowDetails) {
    state = AsyncValue<List<TvshowDetails>>.data([
      ...state.requireValue,
      tvshowDetails,
    ]);
  }

  void deleteFav(int id) {
    final tempState = state.requireValue;
    tempState.removeWhere((element) => element.id == id);

    state = AsyncValue<List<TvshowDetails>>.data(tempState);
  }

  TvshowDetails getFav(int id) =>
      state.requireValue.singleWhere((element) => element.id == id);

  bool hasFav(int id) =>
      state.hasValue &&
      state.requireValue.isNotEmpty &&
      state.requireValue.singleWhereOrNull((element) => element.id == id) !=
          null;
}

final favTvshowsProvider =
    AsyncNotifierProvider<FavTvshowsNotifier, List<TvshowDetails>>(
      FavTvshowsNotifier.new,
    );
