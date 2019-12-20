import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/utils/database_helper.dart';

class Database {
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
    print('Inserted row: $id');
  }

  Future<List<TvshowDetails>> queryList() async {
    final List<TvshowDetails> list = await dbHelper.queryList();
    return list;
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
    print('updated $rowsAffected row(s)');
  }

  Future<int> delete(int id) async {
    final int rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row: $id');
    return id;
  }
}
