import 'package:flutter/foundation.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationStatusState {
  final VerifyDatabaseUseCase _verifyDatabaseUseCase =
      locator<VerifyDatabaseUseCase>();
  final GetMigrationStatusUseCase _getMigrationStatusUseCase =
      locator<GetMigrationStatusUseCase>();
  final SaveMigrationStatusUseCase _saveMigrationStatusUseCase =
      locator<SaveMigrationStatusUseCase>();
  MigrationStatus _migration = MigrationStatus.init;

  MigrationStatus get migration => _migration;
  bool get completeMigration =>
      [MigrationStatus.complete, MigrationStatus.empty].contains(_migration);

  Future<void> loadStatus() async {
    bool isEmpty = await _verifyDatabaseUseCase();
    bool isEmptyOldDatabase = true;
    if (!kIsWeb && !isEmpty) {
      final VerifyOldDatabaseUseCase _verifyOldDatabaseUseCase =
          locator<VerifyOldDatabaseUseCase>();
      isEmptyOldDatabase = await _verifyOldDatabaseUseCase();
    }

    if (isEmpty && isEmptyOldDatabase) {
      _migration = MigrationStatus.empty;
      await _saveMigrationStatusUseCase(
        isEmptyOldDatabase
            ? MigrationStatus.completeDatabase
            : MigrationStatus.complete,
      );
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
