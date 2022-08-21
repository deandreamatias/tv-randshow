import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../models/tvshow_details.dart';
import '../../streaming/data/models/streaming_detail_input.dart';
import '../../streaming/data/models/streaming_detail_output.dart';
import '../../utils/database_helper.dart';
import 'i_database_service.dart';

@Environment("mobile")
@LazySingleton(as: IDatabaseService)
class SqlDatabaseService extends IDatabaseService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Future<bool> deleteTvshow(int id) async {
    try {
      final List<Map<String, dynamic>> streamingsMaps =
          await dbHelper.queryList(
        table: DatabaseHelper.streamingsTable,
        filter: MapEntry(DatabaseHelper.columnStreamingTvshowId, id),
        columns: <String>[
          DatabaseHelper.columnStreamingId,
          DatabaseHelper.columnStreamingName,
          DatabaseHelper.columnStreamingLink,
          DatabaseHelper.columnStreamingCountry,
          DatabaseHelper.columnStreamingLeaving,
          DatabaseHelper.columnStreamingAdded,
          DatabaseHelper.columnStreamingTvshowId,
        ],
      );
      if (streamingsMaps.isNotEmpty) {
        final int streamingsDeleted = await dbHelper.delete(
          table: DatabaseHelper.streamingsTable,
          deletefilter: MapEntry(DatabaseHelper.columnStreamingTvshowId, id),
        );
        log('Deleted $streamingsDeleted streaming row with tvshow id $id');
      }

      final int rowsDeleted = await dbHelper.delete(
        table: DatabaseHelper.tvshowTable,
        deletefilter: MapEntry(DatabaseHelper.columnIdTvshow, id),
      );
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

      final List<Map<String, dynamic>> streamingsMaps =
          await dbHelper.queryList(
        table: DatabaseHelper.streamingsTable,
        columns: <String>[
          DatabaseHelper.columnStreamingId,
          DatabaseHelper.columnStreamingName,
          DatabaseHelper.columnStreamingLink,
          DatabaseHelper.columnStreamingCountry,
          DatabaseHelper.columnStreamingLeaving,
          DatabaseHelper.columnStreamingAdded,
          DatabaseHelper.columnStreamingTvshowId,
        ],
      );
      List<StreamingDetailOutput> streamings = streamingsMaps
          .map((map) => StreamingDetailOutput.fromJson(map))
          .toList();

      return tvShowsMaps.map((i) {
        TvshowDetails tvshow = TvshowDetails.fromJson(i);
        if (streamings.isNotEmpty) {
          tvshow = tvshow.copyWith(
              streamings: streamings
                  .where((streaming) => streaming.tvshowId == tvshow.rowId)
                  .toList());
        }
        return tvshow;
      }).toList();
    } catch (e) {
      log('Error to get db list', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    final tvshowRow = tvshowDetails.toJson();
    final int tvshowRowId = await dbHelper.insert(
      row: tvshowRow,
      table: DatabaseHelper.tvshowTable,
    );
    if (tvshowRowId == 0) {
      log('Error to save tvshow ${tvshowDetails.id}');
      return false;
    }
    log('Tvshow ${tvshowDetails.id} saved');

    tvshowDetails = tvshowDetails.copyWith(rowId: tvshowRowId);
    final savedStreamings = await saveStreamings(tvshowDetails);

    return tvshowRowId.isFinite && savedStreamings;
  }

  @override
  Future<bool> saveStreamings(TvshowDetails tvshowDetails) async {
    final streamings = tvshowDetails.streamings;
    final tvshowRowId = tvshowDetails.rowId!;
    List<int> rowIdAdded = [];
    if (streamings.isNotEmpty) {
      for (final streaming in streamings) {
        final streamingRow = StreamingDetailInput(
          streamingName: streaming.streamingName,
          country: streaming.country,
          link: streaming.link,
          added: streaming.added,
          leaving: streaming.leaving,
          tvshowId: tvshowRowId,
        ).toJson();

        final rowId = await dbHelper.insert(
          row: streamingRow,
          table: DatabaseHelper.streamingsTable,
        );
        rowIdAdded.add(rowId);
      }

      final success = !rowIdAdded.any((rowId) => rowId == 0);
      success
          ? log(
              'Streamings saved on tvshow ${tvshowRowId}: ${streamings.length} streamings')
          : log('Error to save streamings on tv show ${tvshowRowId}');
      return success;
    }
    return true;
  }
}
