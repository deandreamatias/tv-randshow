import 'dart:developer';

import '../models/tvshow_details.dart';
import '../utils/database_helper.dart';

class DatabaseService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> insert(TvshowDetails tvshowDetails) async {
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
  }

  Future<List<TvshowDetails>> queryList() async {
    try {
      final List<TvshowDetails> list = await dbHelper.queryList();
      return list;
    } catch (e) {
      log('Error to get db list', error: e);
      return null;
    }
  }

  Future<void> update(TvshowDetails tvshowDetails) async {
    // row to update
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
    final int rowsAffected = await dbHelper.update(row);
    log('Updated $rowsAffected row(s)');
  }

  Future<void> delete(int id) async {
    try {
      final int rowsDeleted = await dbHelper.delete(id);
      log('Deleted $rowsDeleted row with id $id');
    } catch (e) {
      log('Error to delete row with id $id', error: e);
    }
  }
}
