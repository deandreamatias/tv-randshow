// ignore_for_file: avoid-non-null-assertion

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';

class DatabaseHelper {
  static const String tvshowTable = 'tvshowfav';
  static const String streamingsTable = 'tvshowstreaming';

  static const String columnId = 'rowId';
  static const String columnIdTvshow = 'id';
  static const String columnName = 'name';
  static const String columnPosterPath = 'poster_path';
  static const String columnEpisodes = 'number_of_episodes';
  static const String columnSeasons = 'number_of_seasons';
  static const String columnRunTime = 'episode_run_time';
  static const String columnOverview = 'overview';
  static const String columnInProduction = 'in_production';

  static const String columnStreamingId = 'rowId';
  static const String columnStreamingTvshowId = 'tvshowId';
  static const String columnStreamingName = 'streamingName';
  static const String columnStreamingCountry = 'country';
  static const String columnStreamingLink = 'link';
  static const String columnStreamingLeaving = 'leaving';
  static const String columnStreamingAdded = 'added';

  // Make this a singleton class.
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  String _databaseName = '';
  static const int _databaseVersion = 1;

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  DatabaseHelper._privateConstructor();

  // Helper methods.

  /// Inserts a row in the database where each key in the Map is a column name
  /// and the value is the column value.
  ///
  /// The return value is the id of the inserted row.
  Future<int> insert({
    required Map<String, dynamic> row,
    required String table,
  }) async {
    final Database database = await instance.database;

    return database.insert(table, row);
  }

  /// Get list from `table` on database by selected `columns`.
  Future<List<Map<String, dynamic>>> queryList({
    required String table,
    required List<String> columns,
    MapEntry? filter,
  }) async {
    final Database database = await instance.database;

    return database.query(
      table,
      columns: columns,
      where: filter != null ? '${filter.key} = ?' : null,
      whereArgs: filter != null ? <int?>[filter.value] : null,
    );
  }

  /// Deletes the row specified by the id. The number of affected rows is
  /// returned. This should be 1 as long as the row exists.
  Future<int> delete({
    required String table,
    required MapEntry deletefilter,
  }) async {
    final Database database = await instance.database;

    return database.delete(
      table,
      where: '${deletefilter.key} = ?',
      whereArgs: <int>[deletefilter.value],
    );
  }

  /// Deletes the row specified by the id. The number of affected rows is
  /// returned. This should be 1 as long as the row exists.
  Future<bool> deleteAll() async {
    final Database database = await instance.database;
    final idDeleted = await database.delete(tvshowTable);

    return idDeleted > 0;
  }

  // This opens the database (and creates it if it doesn't exist).
  Future<Database> _initDatabase() async {
    String path = await _getDatabasePath();

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        final batch = db.batch();
        _createTvshowTable(batch);
        // Do not use this return value.
        // ignore: avoid-ignoring-return-values
        await batch.commit();
      },
    );
  }

  Future<String> _getDatabasePath() async {
    Directory? documentsDirectory;
    try {
      documentsDirectory = await getExternalStorageDirectory();
    } catch (e) {
      log('Open directory', error: e);
    }

    _databaseName =
        FlavorConfig.isDevelopment() ? 'tvshowfavdev.db' : 'tvshowfav.db';

    return join(documentsDirectory?.path ?? '', _databaseName);
  }

  // SQL code to create the database tvshows table.
  void _createTvshowTable(Batch batch, {String auxiliar = ''}) {
    final table = auxiliar.isNotEmpty ? auxiliar : tvshowTable;
    batch.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnIdTvshow INTEGER NOT NULL,
            $columnName TEXT NOT NULL,
            $columnPosterPath TEXT,
            $columnEpisodes INTEGER,
            $columnSeasons INTEGER NOT NULL,
            $columnRunTime INTEGER,
            $columnOverview TEXT,
            $columnInProduction INTEGER
          )
          ''');
  }
}
