import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/ui/states/tvshows_provider.dart';

class RandomTvshowNotifier
    extends AutoDisposeFamilyAsyncNotifier<TvshowResult, int> {
  final GetRandomEpisodeUseCase _getRandomEpisodeUseCase =
      locator<GetRandomEpisodeUseCase>();

  late TvshowDetails tvshow;

  @override
  FutureOr<TvshowResult> build(int arg) {
    tvshow = ref.watch(favTvshowsProvider.notifier).getFav(arg);
    return _getRandomEpisode();
  }

  Future<TvshowResult> _getRandomEpisode() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        return _getRandomEpisodeUseCase(
          idTv: arg,
          numberOfSeasons: tvshow.numberOfSeasons,
        );
      },
    );
    return state.requireValue;
  }
}

final randomTvshowProvider = AutoDisposeAsyncNotifierProviderFamily<
    RandomTvshowNotifier, TvshowResult, int>(RandomTvshowNotifier.new);
