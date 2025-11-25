import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_secondary_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@Injectable(env: ['mobile'])
class MobileDatabaseMigrationUseCase {
  final ILocalRepository _localRepository;
  final ISecondaryLocalRepository _secondaryDatabaseService;

  MobileDatabaseMigrationUseCase(
    this._localRepository,
    this._secondaryDatabaseService,
  );

  Stream<MigrationStatus> call() async* {
    final List<TvshowDetails> tvshows = await _secondaryDatabaseService
        .getTvshows();
    yield MigrationStatus.loadedOld;

    if (tvshows.isNotEmpty) {
      for (TvshowDetails tvshow in tvshows) {
        await _localRepository.saveTvshow(tvshow);
      }
      yield MigrationStatus.savedToNew;

      final newTvshows = await _localRepository.getTvshows();

      newTvshows.sort((a, b) => a.id.compareTo(b.id));
      tvshows.sort((a, b) => a.id.compareTo(b.id));

      if (!listEquals(newTvshows, tvshows)) {
        throw Exception('Differences between old and new database');
      }
      yield MigrationStatus.verifyData;

      final result = await _secondaryDatabaseService.deleteAll();
      if (!result) {
        throw Exception('Can not delete old database');
      }
      yield MigrationStatus.deletedOld;
      yield MigrationStatus.completeDatabase;

      return;
    }
    yield MigrationStatus.empty;
  }
}
