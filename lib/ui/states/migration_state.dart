import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_model.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';

class MigrationState extends ValueNotifier<MigrationModel> {
  final AddStreamingsMigrationUseCase _addStreamingsMigrationUseCase =
      locator<AddStreamingsMigrationUseCase>();
  final GetMigrationStatusUseCase _getMigrationStatusUseCase =
      locator<GetMigrationStatusUseCase>();
  final SaveMigrationStatusUseCase _saveMigrationStatusUseCase =
      locator<SaveMigrationStatusUseCase>();
  final VerifyOldDatabaseUseCase _verifyOldDatabaseUseCase =
      locator<VerifyOldDatabaseUseCase>();

  MigrationState({MigrationModel? value})
      : super(value ?? MigrationModel(status: MigrationStatus.init)) {
    loadStatus();
  }

  void loadStatus() async {
    if (!kIsWeb) {
      await _verifyOldDatabaseUseCase();
    }
    value = MigrationModel(status: await _getMigrationStatusUseCase());
    notifyListeners();
  }

  Future<void> initMigration() async {
    if (!kIsWeb) {
      final MobileDatabaseMigrationUseCase _databaseMigrationUseCase =
          locator<MobileDatabaseMigrationUseCase>();
      value = await _databaseMigrationUseCase();
      notifyListeners();
      await _saveMigrationStatusUseCase(value.status);
    }
    value = await _addStreamingsMigrationUseCase();
    notifyListeners();
    await _saveMigrationStatusUseCase(value.status);
  }
}
