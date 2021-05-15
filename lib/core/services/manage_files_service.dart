import 'dart:io';

import 'package:injectable/injectable.dart';

import '../models/file.dart';
import 'app_service.dart';
import 'database_service.dart';

@lazySingleton
class ManageFilesService {
  ManageFilesService({
    DatabaseService databaseService,
    AppService appService,
  })  : _databaseService = databaseService,
        _appService = appService;
  final DatabaseService _databaseService;
  final AppService _appService;
  String downloadPath = '';

  Future<bool> saveTvshows() async {
    if (!(await _appService.hasStoragePermission())) return false;

    final favTvshows = await _databaseService.queryList();
    if (favTvshows == null || favTvshows.isEmpty) return false;

    final jsonFavTvshows = TvshowsFile(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';

    downloadPath = await _appService.saveFile(fileName, jsonFavTvshows);

    return downloadPath != null && downloadPath.isNotEmpty;
  }

  Future<bool> loadTvshows() async {
    final localFile = File(downloadPath);
    final jsonFavTvshows =
        TvshowsFile.fromRawJson(await localFile.readAsString());

    for (final tvshow in jsonFavTvshows.tvshows) {
      await _databaseService.insert(tvshow);
    }
    final loadedTvshows = await _databaseService.queryList();

    return jsonFavTvshows.tvshows.length == loadedTvshows.length;
  }
}
