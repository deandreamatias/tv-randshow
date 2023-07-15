import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@injectable
class AddStreamingsMigrationUseCase {
  final ILocalRepository _localRepository;
  final IStreamingsRepository _streamingsRepository;

  AddStreamingsMigrationUseCase(
    this._localRepository,
    this._streamingsRepository,
  );

  Stream<MigrationStatus> call() async* {
    final List<TvshowDetails> tvshows = await _localRepository.getTvshows();

    if (tvshows.isEmpty) {
      yield MigrationStatus.empty;

      return;
    }

    if (tvshows.every((tvshow) => tvshow.streamings.isEmpty)) {
      for (TvshowDetails tvshow in tvshows) {
        List<StreamingDetail> streamings = [];
        final search = StreamingSearch(
          tmdbId: tvshow.id.toString(),
          country: PlatformDispatcher.instance.locale.countryCode ?? '',
        );
        final tvshowStremings =
            await _streamingsRepository.searchTvShow(search);

        streamings.addAll(tvshowStremings);

        if (streamings.isNotEmpty) {
          tvshow = tvshow.copyWith(streamings: streamings, rowId: tvshow.rowId);
          await _localRepository.saveStreamings(tvshow);
        }
        yield MigrationStatus.addStreaming;
      }
    }
    yield MigrationStatus.complete;
  }
}
