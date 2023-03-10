import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/data/models/tmdb_query_input.dart';
import 'package:tv_randshow/core/tvshow/data/services/tmdb_http_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/search.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';

@Injectable(as: IOnlineRepository)
class TvshowRepository implements IOnlineRepository {
  final String apiVersion = '/3';
  final TmdbHttpService _httpService;
  TvshowRepository(this._httpService);

  @override
  Future<TvshowDetails> getDetailsTv(String language, int idTv) async {
    final query = TmdbQueryInput(language: language);
    final String tvshowDetails = '$apiVersion/tv/';

    final response = await _httpService.get(
      '$tvshowDetails$idTv',
      query.toJson(),
    );

    return TvshowDetails.fromJson(response);
  }

  @override
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    String language,
    int idTv,
    int idSeason,
  ) async {
    final query = TmdbQueryInput(language: language);
    final String tvshowDetails = '$apiVersion/tv/';
    const String tvshowDetailsSeason = '/season/';

    final response = await _httpService.get(
      '$tvshowDetails$idTv$tvshowDetailsSeason$idSeason',
      query.toJson(),
    );

    return TvshowSeasonsDetails.fromJson(response);
  }

  @override
  Future<Search> search({
    required String text,
    required int page,
    required String language,
  }) async {
    final query = TmdbQueryInput(language: language, page: page, query: text);
    final String tvshowSearch = '$apiVersion/search/tv';

    final response = await _httpService.get(
      tvshowSearch,
      query.toJson(),
    );

    return Search.fromJson(response);
  }
}
