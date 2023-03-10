import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';

class RandomTvshowNotifier
    extends AutoDisposeFamilyAsyncNotifier<TvshowResult, int> {
  late final TvshowDetails tvshow =
      ref.watch(favTvshowsProvider.notifier).getFav(arg);

  final GetRandomEpisodeUseCase _getRandomEpisodeUseCase =
      locator<GetRandomEpisodeUseCase>();

  @override
  FutureOr<TvshowResult> build(int arg) {
    return _getRandomEpisode();
  }

  Future<TvshowResult> _getRandomEpisode() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _getRandomEpisodeUseCase(
        idTv: arg,
        numberOfSeasons: tvshow.numberOfSeasons,
      ),
    );

    return state.requireValue;
  }
}

final randomTvshowProvider = AutoDisposeAsyncNotifierProviderFamily<
    RandomTvshowNotifier, TvshowResult, int>(RandomTvshowNotifier.new);
