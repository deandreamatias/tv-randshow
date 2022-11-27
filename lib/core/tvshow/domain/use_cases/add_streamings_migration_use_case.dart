import 'dart:ui' as ui;

import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';

@injectable
class AddStreamingsMigrationUseCase {
  final IDatabaseService _databaseService;
  final IStreamingsRepository _streamingsRepository;

  AddStreamingsMigrationUseCase(
    this._databaseService,
    this._streamingsRepository,
  );

  Stream<MigrationStatus> call() async* {
    final List<TvshowDetails> tvshows = await _databaseService.getTvshows();

    if (tvshows.isEmpty) {
      yield MigrationStatus.empty;
      return;
    }

    if (tvshows.every((tvshow) => tvshow.streamings.isEmpty)) {
      for (TvshowDetails tvshow in tvshows) {
        List<StreamingDetail> streamings = [];
        final search = StreamingSearch(
          tmdbId: tvshow.id.toString(),
          country: ui.window.locale.countryCode ?? '',
        );
        final tvshowStremings =
            await _streamingsRepository.searchTvShow(search);

        streamings.addAll(tvshowStremings.streamings);

        if (streamings.isNotEmpty) {
          tvshow = tvshow.copyWith(streamings: streamings, rowId: tvshow.rowId);
          await _databaseService.saveStreamings(tvshow);
        }
        yield MigrationStatus.addStreaming;
      }
    }
    yield MigrationStatus.complete;
  }
}
