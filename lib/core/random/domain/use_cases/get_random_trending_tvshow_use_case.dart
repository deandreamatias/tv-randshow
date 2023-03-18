import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';
import 'package:tv_randshow/core/trending/domain/use_cases/get_trending_tv_shows_use_case.dart';

@injectable
class GetRandomTrendingTvshowUseCase {
  final GetTrendingTvshowsUseCase _getTrendingTvshowsUseCase;
  final IRandomService _randomService;

  const GetRandomTrendingTvshowUseCase(
    this._getTrendingTvshowsUseCase,
    this._randomService,
  );

  Future<TrendingResult> call() async {
    // Get 3 pages of trending tv shows.
    final firstPage = await _getTrendingTvshowsUseCase();
    final secondPage = await _getTrendingTvshowsUseCase(page: 2);
    final thirdPage = await _getTrendingTvshowsUseCase(page: 3);
    final trendingTvshows = [...firstPage, ...secondPage, ...thirdPage];

    // Get single random trending tv show.
    final index = _randomService.getNumber(max: trendingTvshows.length);

    return trendingTvshows[index];
  }
}
