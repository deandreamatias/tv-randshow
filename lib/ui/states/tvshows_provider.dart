import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/domain/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/domain/models/tvshow_actions.dart';
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

  Future<void> addFav(TvshowDetails tvshowDetails) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<List<TvshowDetails>>(
      () async {
        return [...state.requireValue, tvshowDetails];
      },
    );
  }

  Future<void> deleteFav(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<List<TvshowDetails>>(
      () async {
        final tempState = state.requireValue;
        tempState.removeWhere((element) => element.id == id);
        return tempState;
      },
    );
  }

  TvshowDetails? tvshowInFav(int idTv) => state.hasValue &&
          state.requireValue.isNotEmpty
      ? state.requireValue.singleWhereOrNull((element) => element.id == idTv)
      : null;

  Future<TvshowDetails?> verifyAppLink() async {
    final IAppService appService = locator<IAppService>();
    final TvshowActions tvshowActions = await appService.initUniLinks();
    if (state.hasValue && state.requireValue.isNotEmpty && state.isLoading) {
      return null;
    }
    return state.requireValue.singleWhere(
      (TvshowDetails tvshowDetails) =>
          tvshowDetails.name.toLowerCase().contains(tvshowActions.tvshow),
    );
  }
}

final favTvshowsProvider =
    AsyncNotifierProvider<FavTvshowsNotifier, List<TvshowDetails>>(
  FavTvshowsNotifier.new,
);
