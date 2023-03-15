import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';

final randomTvshowProvider =
    FutureProvider.autoDispose.family<TvshowResult, int>((ref, int tvId) {
  final GetRandomEpisodeUseCase getRandomEpisodeUseCase =
      locator<GetRandomEpisodeUseCase>();

  return getRandomEpisodeUseCase(idTv: tvId);
});
