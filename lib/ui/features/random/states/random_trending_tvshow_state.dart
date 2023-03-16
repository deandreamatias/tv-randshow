import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_trending_tvshow_use_case.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';

final randomTrendingTvshowProvider =
    FutureProvider.autoDispose<TrendingResult>((ref) {
  final GetRandomTrendingTvshowUseCase getRandomTrendingTvshow =
      locator<GetRandomTrendingTvshowUseCase>();

  return getRandomTrendingTvshow();
});
