import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationStatusState {
  MigrationStatusState({required this.isWeb});

  final bool isWeb;

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
    _migration = await _getMigrationStatusUseCase();

    if (completeMigration) return;

    isWeb ? _webStatus() : _mobileStatus();
  }

  Future<void> saveStatus(MigrationStatus status) async {
    if (_migration != MigrationStatus.init) {
      await _saveMigrationStatusUseCase(status);
      _migration = status;
    }
  }

  void _webStatus() async {
    bool isEmpty = await _verifyDatabaseUseCase();

    if (isEmpty) {
      _migration = MigrationStatus.empty;
      return;
    }
  }

  void _mobileStatus() async {
    bool isEmpty = await _verifyDatabaseUseCase();
    bool isEmptyOldDatabase = true;
    if (isEmpty) {
      final VerifyOldDatabaseUseCase _verifyOldDatabaseUseCase =
          locator<VerifyOldDatabaseUseCase>();
      isEmptyOldDatabase = await _verifyOldDatabaseUseCase();

      await saveStatus(
          isEmptyOldDatabase ? MigrationStatus.empty : MigrationStatus.init);
      return;
    }
    await saveStatus(MigrationStatus.completeDatabase);
  }
}
