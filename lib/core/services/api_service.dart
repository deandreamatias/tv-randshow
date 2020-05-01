import 'package:dio/dio.dart';

import '../models/query.dart';
import '../models/search.dart';
import '../models/tvshow_details.dart';
import '../models/tvshow_seasons_details.dart';
import '../utils/constants.dart';
import 'log_service.dart';

class ApiService {
  final LogService _logger = LogService.instance;
  static BaseOptions options = BaseOptions(
    baseUrl: 'https://$apiUrl',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  // Documentation: https://developers.themoviedb.org/3/search/search-tv-shows
  Future<Search> getSearch(Query query) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(TVSHOW_SEARCH,
          queryParameters: query.toJson());
      return Search.fromJson(response?.data);
    } on DioError catch (e) {
      _logger.logger.e('Error to fetch search: ${e.message}', e);
      return null;
    }
  }

// Documentation: https://developers.themoviedb.org/3/tv/get-tv-details
  Future<TvshowDetails> getDetailsTv(Query query, int idTv) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        '$TVSHOW_DETAILS$idTv',
        queryParameters: query.toJson(),
      );
      return TvshowDetails.fromJson(response?.data);
    } on DioError catch (e) {
      _logger.logger.e('Error to fetch Tv show details: ${e.message}', e);
      return null;
    }
  }

// Documentation: https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
      Query query, int idTv, int idSeason) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        '$TVSHOW_DETAILS$idTv$TVSHOW_DETAILS_SEASON$idSeason',
        queryParameters: query.toJson(),
      );
      return TvshowSeasonsDetails.fromJson(response?.data);
    } on DioError catch (e) {
      _logger.logger
          .e('Error to fetch Tvshow seasons details: ${e.message}', e);
      return null;
    }
  }
}
