import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_model.dart';
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

  Stream<MigrationModel> call() async* {
    final List<TvshowDetails> tvshows =
        await _secondaryDatabaseService.getTvshows();
    yield MigrationModel(status: MigrationStatus.loadedOld);

    if (tvshows.isNotEmpty) {
      for (TvshowDetails tvshow in tvshows) {
        final success = await _databaseService.saveTvshow(tvshow);
        if (!success) {
          yield MigrationModel(
            error: 'Error to save tv show ${tvshow.id}',
            status: MigrationStatus.loadedOld,
          );
          return;
        }
      }
      yield MigrationModel(status: MigrationStatus.savedToNew);

      final newTvshows = await _databaseService.getTvshows();

      if (!listEquals(tvshows, newTvshows)) {
        log('Error to migrate tvshows: Lists different');
        log(tvshows.toString());
        log(newTvshows.toString());
        yield MigrationModel(
          error: 'Error on database verification',
          status: MigrationStatus.savedToNew,
        );
        return;
      }
      yield MigrationModel(status: MigrationStatus.verifyData);

      final result = await _secondaryDatabaseService.deleteAll();
      if (result) {
        yield MigrationModel(status: MigrationStatus.deletedOld);
      } else {
        yield MigrationModel(
          error: 'Error to delete old database',
          status: MigrationStatus.verifyData,
        );
      }
      return;
    }
    yield MigrationModel(status: MigrationStatus.emptyOld);
  }
}
