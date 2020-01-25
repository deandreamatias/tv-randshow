import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/query.dart';
import '../models/search.dart';
import '../models/tvshow_details.dart';
import '../models/tvshow_seasons_details.dart';
import '../utils/constants.dart';
import 'log_service.dart';

class ApiService {
  final LogService _logger = LogService.instance;

  Future<Search> getSearch(Query query) async {
    final Uri uri = Uri.https(apiUrl, TVSHOW_SEARCH, query.toJson());
    final Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return Search.fromRawJson(response?.body);
    } else {
      _logger.logger.e(
          'Error to fetch data: ${response.reasonPhrase}', response.statusCode);
      return null;
    }
  }

  Future<TvshowDetails> getDetailsTv(Query query, int idTv) async {
    final Uri uri = Uri.https(apiUrl, '$TVSHOW_DETAILS$idTv', query.toJson());
    final Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvshowDetails.fromRawJson(response?.body);
    } else {
      _logger.logger.e(
          'Error to fetch data: ${response.reasonPhrase}', response.statusCode);
      return null;
    }
  }

  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
      Query query, int idTv, int idSeason) async {
    final Uri uri = Uri.https(
      apiUrl,
      '$TVSHOW_DETAILS$idTv$TVSHOW_DETAILS_SEASON$idSeason',
      query.toJson(),
    );
    final Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvshowSeasonsDetails.fromRawJson(response?.body);
    } else {
      _logger.logger.e(
          'Error to fetch data: ${response.reasonPhrase}', response.statusCode);
      return null;
    }
  }
}
