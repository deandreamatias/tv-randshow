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
      final List<TvshowDetails> list = await dbHelper.queryTvshowsDetails();
      return list;
    } catch (e) {
      log('Error to get db list', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    final int id = await dbHelper.insert(tvshowDetails);
    log('Inserted row: $id');
    return id.isFinite;
  }
}
