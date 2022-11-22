import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';

@Environment("mobile")
@injectable
class MobileDatabaseMigrationUseCase {
  final IDatabaseService _databaseService;
  final ISecondaryDatabaseService _secondaryDatabaseService;

  MobileDatabaseMigrationUseCase(
    this._databaseService,
    this._secondaryDatabaseService,
  );

  Stream<MigrationStatus> call() async* {
    final List<TvshowDetails> tvshows =
        await _secondaryDatabaseService.getTvshows();
    yield MigrationStatus.loadedOld;

    if (tvshows.isNotEmpty) {
      for (TvshowDetails tvshow in tvshows) {
        await _databaseService.saveTvshow(tvshow);
      }
      yield MigrationStatus.savedToNew;

      final newTvshows = await _databaseService.getTvshows();

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
    yield MigrationStatus.emptyOld;
  }
}
