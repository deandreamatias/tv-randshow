import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationState {
  final AddStreamingsMigrationUseCase _addStreamingsMigrationUseCase =
      locator<AddStreamingsMigrationUseCase>();
  final GetMigrationStatusUseCase _getMigrationStatusUseCase =
      locator<GetMigrationStatusUseCase>();
  final SaveMigrationStatusUseCase _saveMigrationStatusUseCase =
      locator<SaveMigrationStatusUseCase>();
  final VerifyOldDatabaseUseCase _verifyOldDatabaseUseCase =
      locator<VerifyOldDatabaseUseCase>();

  StreamController<MigrationStatus> _streamController =
      StreamController.broadcast();
  MigrationStatus _migration = MigrationStatus.init;

  MigrationStatus get migration => _migration;
  Stream<MigrationStatus> get stream => _streamController.stream
      .takeWhile((model) => model != MigrationStatus.complete);
  Future<dynamic> Function() get close => _streamController.close;

  MigrationState() {
    loadStatus();
  }

  void loadStatus() async {
    if (!kIsWeb) await _verifyOldDatabaseUseCase();

    _migration = await _getMigrationStatusUseCase();
  }

  Future<void> initMigration() async {
    _streamController.add(migration);
    if (!kIsWeb) {
      final MobileDatabaseMigrationUseCase _databaseMigrationUseCase =
          locator<MobileDatabaseMigrationUseCase>();
      _streamController.addStream(_databaseMigrationUseCase());
    }
    _streamController.addStream(_addStreamingsMigrationUseCase());
    // await _saveMigrationStatusUseCase(await _streamController.stream);
  }
}
