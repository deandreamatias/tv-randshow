import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/trending/domain/interfaces/i_trending_repository.dart';
import 'package:tv_randshow/core/trending/domain/models/media_type_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/time_window_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class GetTrendingTvshowsUseCase {
  final ITrendingRepository _trendingRepository;

  const GetTrendingTvshowsUseCase(this._trendingRepository);

  Future<List<TrendingResult>> call({int page = 1}) async {
    final pagination = await _trendingRepository.getTrending(
      mediaType: MediaTypeEnum.tv,
      timeWindow: TimeWindowEnum.week,
      language: Helpers.getLocale(),
      page: page,
    );

    return pagination.results;
  }
}
