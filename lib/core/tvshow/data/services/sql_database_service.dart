import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/services/database_helper.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_secondary_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@LazySingleton(as: ISecondaryDatabaseService, env: ['mobile'])
class SqlDatabaseService extends ISecondaryDatabaseService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Future<bool> deleteAll() async {
    try {
      return await dbHelper.deleteAll();
    } catch (e) {
      log('Error to delete tvshow rows', error: e);
      return false;
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    try {
      final List<Map<String, dynamic>> tvShowsMaps = await dbHelper.queryList(
        table: DatabaseHelper.tvshowTable,
        columns: <String>[
          DatabaseHelper.columnId,
          DatabaseHelper.columnIdTvshow,
          DatabaseHelper.columnName,
          DatabaseHelper.columnPosterPath,
          DatabaseHelper.columnEpisodes,
          DatabaseHelper.columnSeasons,
          DatabaseHelper.columnRunTime,
          DatabaseHelper.columnOverview,
          DatabaseHelper.columnInProduction,
        ],
      );

      return tvShowsMaps.map((i) => TvshowDetails.fromJson(i)).toList();
    } catch (e) {
      log('Error to get db list', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshows(List<TvshowDetails> tvshows) async {
    for (var tvshow in tvshows) {
      final tvshowRow = tvshow.toJson();
      final int tvshowRowId = await dbHelper.insert(
        row: tvshowRow,
        table: DatabaseHelper.tvshowTable,
      );
      if (tvshowRowId == 0) {
        log('Error to save tvshow ${tvshow.id}');
        return false;
      }
      log('Tvshow ${tvshow.id} saved');

      return tvshowRowId.isFinite;
    }
    return true;
  }
}
