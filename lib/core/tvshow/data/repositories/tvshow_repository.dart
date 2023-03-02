import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/search.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/tvshow/data/services/tvshow_http_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_tvshow_repository.dart';

@Injectable(as: ITvshowRepository)
class TvshowRepository implements ITvshowRepository {
  final TvshowHttpService _httpService;
  final String apiVersion = '/3';
  TvshowRepository(this._httpService);

  @override
  Future<TvshowDetails> getDetailsTv(Query query, int idTv) async {
    final String tvshowDetails = '$apiVersion/tv/';

    final response = await _httpService.get(
      '$tvshowDetails$idTv',
      query.toJson(),
    );
    return TvshowDetails.fromJson(response);
  }

  @override
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    Query query,
    int idTv,
    int idSeason,
  ) async {
    final String tvshowDetails = '$apiVersion/tv/';
    const String tvshowDetailsSeason = '/season/';

    final response = await _httpService.get(
      '$tvshowDetails$idTv$tvshowDetailsSeason$idSeason',
      query.toJson(),
    );
    return TvshowSeasonsDetails.fromJson(response);
  }

  @override
  Future<Search> search(Query query) async {
    final String tvshowSearch = '$apiVersion/search/tv';

    final response = await _httpService.get(
      tvshowSearch,
      query.toJson(),
    );
    return Search.fromJson(response);
  }
}
