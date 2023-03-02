import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/data/services/app_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/file.dart';

@lazySingleton
class ManageFilesService {
  ManageFilesService({
    required this.databaseService,
    required this.appService,
  });
  final IDatabaseService databaseService;
  final AppService appService;
  String downloadPath = '';

  Future<bool> saveTvshows() async {
    if (!(await appService.hasStoragePermission())) return false;

    final favTvshows = await databaseService.getTvshows();
    if (favTvshows.isEmpty) return false;

    final jsonFavTvshows = TvshowsFile(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';

    downloadPath = await appService.saveFile(fileName, jsonFavTvshows);

    return downloadPath.isNotEmpty;
  }

  Future<bool> loadTvshows() async {
    final localFile = File(downloadPath);
    final jsonFavTvshows =
        TvshowsFile.fromRawJson(await localFile.readAsString());

    for (final tvshow in jsonFavTvshows.tvshows) {
      await databaseService.saveTvshow(tvshow);
    }
    final loadedTvshows = await databaseService.getTvshows();

    return jsonFavTvshows.tvshows.length == loadedTvshows.length;
  }
}
