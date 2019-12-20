import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  String _databaseName;
  static const int _databaseVersion = 1;
  static const String table = 'tvshowfav';

  static const String columnId = 'rowId';
  static const String columnIdTvshow = 'id';
  static const String columnName = 'name';
  static const String columnPosterPath = 'poster_path';
  static const String columnEpisodes = 'number_of_episodes';
  static const String columnSeasons = 'number_of_seasons';
  static const String columnRunTime = 'episode_run_time';
  static const String columnOverview = 'overview';
  static const String columnInProduction = 'in_production';

  // make this a singleton class
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory;
    try {
      if (Platform.isAndroid) {
        documentsDirectory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        documentsDirectory = await getExternalStorageDirectory();
      }
    } catch (e) {
      print(e);
    }

    if (FlavorConfig.isDevelopment()) {
      _databaseName = 'tvshowfavdev.db';
    } else {
      _databaseName = 'tvshowfav.db';
    }
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnIdTvshow INTEGER NOT NULL,
            $columnName TEXT NOT NULL,
            $columnPosterPath TEXT NOT NULL,
            $columnEpisodes INTEGER NOT NULL,
            $columnSeasons INTEGER NOT NULL,
            $columnRunTime INTEGER NOT NULL,
            $columnOverview TEXT NOT NULL,
            $columnInProduction INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<TvshowDetails>> queryList() async {
    final Database db = await instance.database;

    final List<Map<dynamic, dynamic>> maps =
        await db.query(table, columns: <String>[
      columnId,
      columnIdTvshow,
      columnName,
      columnPosterPath,
      columnEpisodes,
      columnSeasons,
      columnRunTime,
      columnOverview,
      columnInProduction,
    ]);

    return maps
        .map((Map<dynamic, dynamic> i) => TvshowDetails.fromJson(i))
        .toList();
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    final int id = row[columnId];
    return await db
        .update(table, row, where: '$columnId = ?', whereArgs: <int>[id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    final Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: <int>[id]);
  }
}
