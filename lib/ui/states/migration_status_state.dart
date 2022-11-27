import 'package:flutter/foundation.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationStatusState {
  final GetMigrationStatusUseCase _getMigrationStatusUseCase =
      locator<GetMigrationStatusUseCase>();
  final SaveMigrationStatusUseCase _saveMigrationStatusUseCase =
      locator<SaveMigrationStatusUseCase>();
  final VerifyOldDatabaseUseCase _verifyOldDatabaseUseCase =
      locator<VerifyOldDatabaseUseCase>();
  MigrationStatus _migration = MigrationStatus.init;

  MigrationStatus get migration => _migration;
  bool get completeMigration =>
      [MigrationStatus.complete, MigrationStatus.emptyOld].contains(_migration);

  Future<void> loadStatus() async {
    final isEmpty = kIsWeb ? false : await _verifyOldDatabaseUseCase();

    if (isEmpty) {
      _migration = MigrationStatus.emptyOld;
      await _saveMigrationStatusUseCase(MigrationStatus.completeDatabase);
      return;
    }
    _migration = await _getMigrationStatusUseCase();
  }

  void saveStatus(MigrationStatus status) async {
    if (_migration != MigrationStatus.init) {
      await _saveMigrationStatusUseCase(status);
      _migration = status;
    }
  }
}
