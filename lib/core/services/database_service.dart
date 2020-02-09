import 'package:tv_randshow/core/models/tvshow_details.dart';

import '../utils/database_helper.dart';
import 'log_service.dart';

class DatabaseService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final LogService _logger = LogService.instance;

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
    _logger.logger.i('Inserted row: $id');
  }

  Future<List<TvshowDetails>> queryList() async {
    try {
      final List<TvshowDetails> list = await dbHelper.queryList();
      return list;
    } catch (e) {
      _logger.logger.e('Error to get db list', e);
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
    _logger.logger.i('Updated $rowsAffected row(s)');
  }

  Future<void> delete(int id) async {
    try {
      final int rowsDeleted = await dbHelper.delete(id);
      _logger.logger.i('Deleted $rowsDeleted row');
    } catch (e) {
      _logger.logger.e('Error to delete row $id: $e');
    }
  }
}
