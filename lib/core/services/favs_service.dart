import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../config/flavor_config.dart';
import '../models/query.dart';
import '../models/tvshow_details.dart';
import 'api_service.dart';
import 'hive_database_service.dart';

@lazySingleton
class FavsService {
  FavsService({
    ApiService apiService,
    HiveDatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;
  final ApiService _apiService;
  final HiveDatabaseService _databaseService;

  StreamController<List<TvshowDetails>> streamController =
      StreamController<List<TvshowDetails>>.broadcast();

  Stream<List<TvshowDetails>> get listFavs => streamController.stream;

  Future<void> getFavs() async {
    streamController.add(await _databaseService.getTvshows());
  }

  Future<void> addFav(int id, String language) async {
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails _tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (_tvshowDetails != null) {
      await _databaseService.saveTvshow(_tvshowDetails);
    }
  }

  Future<void> deleteFav(int id) async {
    await _databaseService.deleteTvshow(id);
    streamController.add(await _databaseService.getTvshows());
  }
}
