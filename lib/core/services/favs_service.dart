import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../config/flavor_config.dart';
import '../models/query.dart';
import '../models/tvshow_details.dart';
import 'api_service.dart';
import 'database_service.dart';

@lazySingleton
class FavsService {
  FavsService({
    ApiService apiService,
    DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;
  final ApiService _apiService;
  final DatabaseService _databaseService;

  StreamController<List<TvshowDetails>> streamController =
      StreamController<List<TvshowDetails>>.broadcast();

  Stream<List<TvshowDetails>> get listFavs => streamController.stream;

  Future<void> getFavs() async {
    streamController.add(await _databaseService.queryList());
  }

  Future<void> addFav(int id, String language) async {
    final Query query = Query(
      apiKey: FlavorConfig.instance.values.apiKey,
      language: language,
    );
    final TvshowDetails _tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (_tvshowDetails != null) {
      await _databaseService.insert(_tvshowDetails);
    }
  }

  Future<void> deleteFav(int rowId) async {
    await _databaseService.delete(rowId);
    streamController.add(await _databaseService.queryList());
  }
}
