import 'dart:async';
import 'dart:ui' as ui;

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';

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

  Future<void> addFav(int tmdbId, String language) async {
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    TvshowDetails tvshowDetails = await _apiService.getDetailsTv(query, tmdbId);

    final streamings = await _getTvshowStreamingsUseCase(
      StreamingSearch(
        tmdbId: tmdbId.toString(),
        country: ui.window.locale.countryCode ?? '',
      ),
    );
    tvshowDetails = tvshowDetails.copyWith(streamings: streamings);

    await _databaseService.saveTvshow(tvshowDetails);
  }

  Future<void> deleteFav(int id) async {
    await _databaseService.deleteTvshow(id);
    streamController.add(await _databaseService.getTvshows());
  }
}
