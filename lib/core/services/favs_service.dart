import 'dart:async';
import 'dart:ui' as ui;

import 'package:injectable/injectable.dart';

import '../../config/flavor_config.dart';
import '../../config/locator.dart';
import '../models/query.dart';
import '../models/tvshow_details.dart';
import '../streaming/domain/models/streaming_search.dart';
import '../streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';
import 'api_service.dart';
import 'databases/i_database_service.dart';

@lazySingleton
class FavsService {
  FavsService({
    required ApiService apiService,
    required IDatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;
  final ApiService _apiService;
  final IDatabaseService _databaseService;
  final GetTvshowStreamingsUseCase _getTvshowStreamingsUseCase =
      locator<GetTvshowStreamingsUseCase>();

  StreamController<List<TvshowDetails>> streamController =
      StreamController<List<TvshowDetails>>.broadcast();

  Stream<List<TvshowDetails>> get listFavs => streamController.stream;

  Future<void> getFavs() async {
    streamController.add(await _databaseService.getTvshows());
  }

  Future<bool> addFav(int tmdbId, String language) async {
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    TvshowDetails _tvshowDetails =
        await _apiService.getDetailsTv(query, tmdbId);

    final streamings = await _getTvshowStreamingsUseCase(
      StreamingSearch(
        tmdbId: tmdbId.toString(),
        country: ui.window.locale.countryCode ?? '',
      ),
    );
    _tvshowDetails = _tvshowDetails.copyWith(streamings: streamings);

    return await _databaseService.saveTvshow(_tvshowDetails);
  }

  Future<void> deleteFav(int id) async {
    await _databaseService.deleteTvshow(id);
    streamController.add(await _databaseService.getTvshows());
  }
}
