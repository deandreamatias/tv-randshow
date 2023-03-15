import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_from_all_tvshows_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';

final randomTvshowsProvider = FutureProvider.autoDispose<TvshowResult>((ref) {
  final GetRandomEpisodeFromAllTvshowsUseCase getRandomEpisodeFromAllTvshows =
      locator<GetRandomEpisodeFromAllTvshowsUseCase>();

  return getRandomEpisodeFromAllTvshows();
});
