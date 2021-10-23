import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../models/tvshow_details.dart';
import '../../utils/database_helper.dart';
import 'i_database_service.dart';

@Environment("mobile")
@LazySingleton(as: IDatabaseService)
class SqlDatabaseService extends IDatabaseService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Future<bool> deleteTvshow(int id) async {
    try {
      final int rowsDeleted = await dbHelper.delete(id);
      log('Deleted $rowsDeleted row with tvshow id $id');
      return rowsDeleted.isFinite;
    } catch (e) {
      log('Error to delete row with tvshow id $id', error: e);
      return false;
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    try {
      final List<TvshowDetails> list = await dbHelper.queryList();
      return list;
    } catch (e) {
      log('Error to get db list', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    // row to insert
    final Map<String, dynamic> row = <String, dynamic>{
      DatabaseHelper.columnId: tvshowDetails.rowId,
      DatabaseHelper.columnIdTvshow: tvshowDetails.id,
      DatabaseHelper.columnName: tvshowDetails.name,
      DatabaseHelper.columnPosterPath: tvshowDetails.posterPath,
      DatabaseHelper.columnEpisodes: tvshowDetails.numberOfEpisodes,
      DatabaseHelper.columnSeasons: tvshowDetails.numberOfSeasons,
      DatabaseHelper.columnRunTime: tvshowDetails.episodeRunTime,
      DatabaseHelper.columnOverview: tvshowDetails.overview,
      DatabaseHelper.columnInProduction: tvshowDetails.inProduction,
    };
    final int id = await dbHelper.insert(row);
    log('Inserted row: $id');
    return id.isFinite;
  }
}
