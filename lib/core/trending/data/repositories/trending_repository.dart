import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/data/models/pagination_data_model.dart';
import 'package:tv_randshow/core/app/data/models/tmdb_query_input.dart';
import 'package:tv_randshow/core/app/data/services/tmdb_http_service.dart';
import 'package:tv_randshow/core/trending/data/models/trending_result_data_model.dart';
import 'package:tv_randshow/core/trending/domain/interfaces/i_trending_repository.dart';
import 'package:tv_randshow/core/trending/domain/models/media_type_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/time_window_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';

@Injectable(as: ITrendingRepository)
class TrendingRepository implements ITrendingRepository {
  final String apiVersion = '/3';
  final TmdbHttpService _httpService;
  TrendingRepository(this._httpService);

  @override
  Future<PaginationDataModel<TrendingResult>> getTrending({
    required MediaTypeEnum mediaType,
    required TimeWindowEnum timeWindow,
    required String language,
    int page = 1,
  }) async {
    final query = TmdbQueryInput(language: language, page: page);
    final String endpoint =
        '$apiVersion/trending/${mediaType.name}/${timeWindow.name}';

    final response = await _httpService.get(endpoint, query: query.toJson());

    return PaginationDataModel<TrendingResult>.fromJson(
      response,
      (json) =>
          TrendingResultDataModel.fromJson(
            json as Map<String, dynamic>,
          ).toDomain(),
    );
  }
}
