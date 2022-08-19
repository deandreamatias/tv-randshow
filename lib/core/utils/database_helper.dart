import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tv_randshow/core/streaming/data/models/streaming_detail_output.dart';

import '../../config/flavor_config.dart';
import '../models/tvshow_details.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  String _databaseName = '';
  static const int _databaseVersion = 2;
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

  // make this a singleton class
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory? documentsDirectory;
    try {
      documentsDirectory = await getExternalStorageDirectory();
    } catch (e) {
      log('Open directory', error: e);
    }

    if (FlavorConfig.isDevelopment()) {
      _databaseName = 'tvshowfavdev.db';
    } else {
      _databaseName = 'tvshowfav.db';
    }
    final String path = join(documentsDirectory?.path ?? '', _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: onConfigure,
      onCreate: (db, version) async {
        final batch = db.batch();
        _createTvshowTable(batch);
        _createStreamingsTable(batch);
        await batch.commit();
      },
      onUpgrade: (db, oldVersion, version) async {
        var batch = db.batch();
        if (oldVersion == 1) {
          _createStreamingsTable(batch);
        }
        await batch.commit();
      },
    );
  }

  // SQL code to create the database streamings table
  void _createStreamingsTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $streamingsTable');
    batch.execute('''
          CREATE TABLE $streamingsTable (
            $columnStreamingId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnStreamingName TEXT,
            $columnStreamingLink TEXT,
            $columnStreamingCountry TEXT,
            $columnStreamingLeaving INTEGER,
            $columnStreamingAdded INTEGER,
            $columnStreamingTvshowId INTEGER,
            FOREIGN KEY ($columnStreamingTvshowId) REFERENCES $tvshowTable($columnId) ON DELETE CASCADE
          )''');
  }

  // SQL code to create the database tvshows table
  void _createTvshowTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $tvshowTable');
    batch.execute('''
          CREATE TABLE $tvshowTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
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

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(TvshowDetails tvshowDetails) async {
    final Database db = await instance.database;

    final Map<String, dynamic> row = <String, dynamic>{
      DatabaseHelper.columnIdTvshow: tvshowDetails.id,
      DatabaseHelper.columnName: tvshowDetails.name,
      DatabaseHelper.columnPosterPath: tvshowDetails.posterPath,
      DatabaseHelper.columnEpisodes: tvshowDetails.numberOfEpisodes,
      DatabaseHelper.columnSeasons: tvshowDetails.numberOfSeasons,
      DatabaseHelper.columnRunTime: tvshowDetails.episodeRunTime,
      DatabaseHelper.columnOverview: tvshowDetails.overview,
      DatabaseHelper.columnInProduction: tvshowDetails.inProduction,
    };

    final rowId = await db.insert(tvshowTable, row);
    if (tvshowDetails.streamings.isNotEmpty) {
      for (final streaming in tvshowDetails.streamings) {
        final map = {
          DatabaseHelper.columnStreamingTvshowId: rowId,
          DatabaseHelper.columnStreamingName: streaming.streamingName,
          DatabaseHelper.columnStreamingLink: streaming.link,
          DatabaseHelper.columnStreamingAdded: streaming.added,
          DatabaseHelper.columnStreamingCountry: streaming.country,
          DatabaseHelper.columnStreamingLeaving: streaming.leaving,
        };
        await db.insert(streamingsTable, map);
      }
    }
    return rowId;
  }

  Future<List<TvshowDetails>> queryTvshowsDetails() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> tvshows =
        await db.query(tvshowTable, columns: <String>[
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

    final streamings = await _queryStreamings();

    return tvshows.map((i) {
      TvshowDetails tvshow = TvshowDetails.fromJson(i);
      tvshow = tvshow.copyWith(
          streamings: streamings
              .where((streaming) => streaming.tvshowId == tvshow.rowId)
              .toList());
      return tvshow;
    }).toList();
  }

  Future<List<StreamingDetailOutput>> _queryStreamings({int? tvshowId}) async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> mapStreamings = await db.query(
      streamingsTable,
      where: tvshowId != null ? '$columnStreamingTvshowId = ?' : null,
      whereArgs: tvshowId != null ? <int?>[tvshowId] : null,
      columns: <String>[
        columnStreamingId,
        columnStreamingName,
        columnStreamingLink,
        columnStreamingCountry,
        columnStreamingLeaving,
        columnStreamingAdded,
        columnStreamingTvshowId,
      ],
    );

    return mapStreamings.map((e) => StreamingDetailOutput.fromJson(e)).toList();
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    final Database db = await instance.database;
    final streamings = await _queryStreamings(tvshowId: id);
    if (streamings.isNotEmpty) {
      await db.delete(
        streamingsTable,
        where: '$columnStreamingTvshowId = ?',
        whereArgs: <int>[id],
      );
    }
    final idDeleted = await db.delete(tvshowTable,
        where: '$columnIdTvshow = ?', whereArgs: <int>[id]);
    return idDeleted;
  }
}
