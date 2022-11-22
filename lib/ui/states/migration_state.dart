import 'dart:async';

import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationState {
  final MobileDatabaseMigrationUseCase _databaseMigrationUseCase =
      locator<MobileDatabaseMigrationUseCase>();
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
  bool get completeMigration => [
        MigrationStatus.completeDatabase,
        MigrationStatus.emptyOld
      ].contains(_migration);
  Stream<MigrationStatus> get stream => _streamController.stream;
  Future<dynamic> Function() get close => _streamController.close;

  Future<void> loadStatus() async {
    final isNotEmpty = await _verifyOldDatabaseUseCase();

    if (!isNotEmpty) {
      _migration = MigrationStatus.emptyOld;
      await _saveMigrationStatusUseCase(MigrationStatus.completeDatabase);
      return;
    }
    _migration = await _getMigrationStatusUseCase();
  }

  void initMigration() {
    _streamController.add(_migration);
    _streamController.addStream(_databaseMigrationUseCase());
  }

  void saveStatus(MigrationStatus status) async {
    if (_migration != MigrationStatus.init) {
      await _saveMigrationStatusUseCase(status);
      _migration = status;
      if (status == MigrationStatus.completeDatabase) {
        close();
      }
    }
  }
}
