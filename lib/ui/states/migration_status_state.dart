import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationStatusState {
  MigrationStatusState({
    required this.isWeb,
    VerifyDatabaseUseCase? verifyDatabaseUseCase,
    GetMigrationStatusUseCase? getMigrationStatusUseCase,
    SaveMigrationStatusUseCase? saveMigrationStatusUseCase,
    VerifyOldDatabaseUseCase? verifyOldDatabaseUseCase,
  }) {
    _verifyDatabaseUseCase =
        verifyDatabaseUseCase ?? locator<VerifyDatabaseUseCase>();
    _getMigrationStatusUseCase =
        getMigrationStatusUseCase ?? locator<GetMigrationStatusUseCase>();
    _saveMigrationStatusUseCase =
        saveMigrationStatusUseCase ?? locator<SaveMigrationStatusUseCase>();
    _verifyOldDatabaseUseCase = verifyOldDatabaseUseCase;
  }

  final bool isWeb;

  late VerifyDatabaseUseCase _verifyDatabaseUseCase;
  late GetMigrationStatusUseCase _getMigrationStatusUseCase;
  late SaveMigrationStatusUseCase _saveMigrationStatusUseCase;
  VerifyOldDatabaseUseCase? _verifyOldDatabaseUseCase;
  MigrationStatus _migration = MigrationStatus.init;

  MigrationStatus get migration => _migration;
  bool get completeMigration =>
      [MigrationStatus.complete, MigrationStatus.empty].contains(_migration);

  Future<void> loadStatus() async {
    _migration = await _getMigrationStatusUseCase();

    if (completeMigration) return;

    isWeb ? await _webStatus() : await _mobileStatus();
  }

  Future<void> saveStatus(MigrationStatus status) async {
    if (status != MigrationStatus.init) {
      await _saveMigrationStatusUseCase(status);
      _migration = status;
    }
  }

  Future<void> _webStatus() async {
    bool isEmpty = await _verifyDatabaseUseCase();

    if (isEmpty) {
      _migration = MigrationStatus.empty;
    }
  }

  Future<void> _mobileStatus() async {
    bool isEmpty = await _verifyDatabaseUseCase();
    if (isEmpty) {
      bool isEmptyOldDatabase = true;
      _verifyOldDatabaseUseCase ??= locator<VerifyOldDatabaseUseCase>();
      isEmptyOldDatabase = await _verifyOldDatabaseUseCase?.call() ?? false;

      if (isEmptyOldDatabase) {
        await saveStatus(MigrationStatus.empty);
      }
      return;
    }
    await saveStatus(MigrationStatus.completeDatabase);
  }
}
