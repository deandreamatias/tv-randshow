import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';

import 'migration_status_state.dart';

class MigrationState {
  final AddStreamingsMigrationUseCase _addStreamingsMigrationUseCase =
      locator<AddStreamingsMigrationUseCase>();

  StreamController<MigrationStatus> _streamController = StreamController();
  MigrationStatusState _migrationStatusState = MigrationStatusState();

  Stream<MigrationStatus> get stream => _streamController.stream;
  Future<dynamic> Function() get close => _streamController.close;

  void initMigration() {
    _streamController.add(_migrationStatusState.migration);
    if (!kIsWeb) {
      final MobileDatabaseMigrationUseCase _databaseMigrationUseCase =
          locator<MobileDatabaseMigrationUseCase>();
      _streamController.addStream(_databaseMigrationUseCase()).then(
          (_) => _streamController.addStream(_addStreamingsMigrationUseCase()));
    } else {
      _streamController.addStream(_addStreamingsMigrationUseCase());
    }
  }

  void updateStatus(MigrationStatus status) async {
    _migrationStatusState.saveStatus(status);
    if (status == MigrationStatus.complete) {
      await close();
    }
  }
}
