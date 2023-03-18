import 'dart:async';

import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/ui/features/migration/migration_status_state.dart';

class MigrationState {
  final bool isWeb;

  late final MigrationStatusState _migrationStatusState =
      MigrationStatusState(isWeb: isWeb);
  final AddStreamingsMigrationUseCase _addStreamingsMigrationUseCase =
      locator<AddStreamingsMigrationUseCase>();

  final StreamController<MigrationStatus> _streamController =
      StreamController();

  Stream<MigrationStatus> get stream => _streamController.stream;
  Future<void> Function() get close => _streamController.close;

  MigrationState({required this.isWeb});

  void initMigration() async {
    _streamController.add(_migrationStatusState.migration);
    if (!isWeb) {
      final MobileDatabaseMigrationUseCase databaseMigrationUseCase =
          locator<MobileDatabaseMigrationUseCase>();
      // Do not use this return value.
      // ignore: avoid-ignoring-return-values, prefer-async-await
      _streamController.addStream(databaseMigrationUseCase()).then(
            (_) =>
                _streamController.addStream(_addStreamingsMigrationUseCase()),
          );

      return;
    }
    // Do not use this return value.
    // ignore: avoid-ignoring-return-values
    _streamController.addStream(_addStreamingsMigrationUseCase());
  }

  void updateStatus(MigrationStatus status) async {
    _migrationStatusState.saveStatus(status);
    if (status == MigrationStatus.complete) {
      await close();
    }
  }
}
