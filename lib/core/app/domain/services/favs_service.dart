import 'dart:async';
import 'dart:ui' as ui;

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_database_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_tvshow_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@lazySingleton
class FavsService {
  FavsService({
    required ITvshowRepository tvshowRepository,
    required IDatabaseRepository databaseService,
  })  : _tvshowRepository = tvshowRepository,
        _databaseService = databaseService;
  final ITvshowRepository _tvshowRepository;
  final IDatabaseRepository _databaseService;
  final GetTvshowStreamingsUseCase _getTvshowStreamingsUseCase =
      locator<GetTvshowStreamingsUseCase>();

  StreamController<List<TvshowDetails>> streamController =
      StreamController<List<TvshowDetails>>.broadcast();

  Stream<List<TvshowDetails>> get listFavs => streamController.stream;

  Future<void> getFavs() async {
    streamController.add(await _databaseService.getTvshows());
  }

  Future<void> addFav(int tmdbId, String language) async {
    final Query query = Query(language: language);
    TvshowDetails tvshowDetails =
        await _tvshowRepository.getDetailsTv(query, tmdbId);

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
