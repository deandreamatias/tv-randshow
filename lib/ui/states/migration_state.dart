import 'dart:async';

import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/mobile_database_migration_use_case.dart';

import 'package:tv_randshow/ui/states/migration_status_state.dart';

class MigrationState {
  MigrationState({required this.isWeb}) {
    _migrationStatusState = MigrationStatusState(isWeb: isWeb);
  }

  final bool isWeb;
  late MigrationStatusState _migrationStatusState;
  final AddStreamingsMigrationUseCase _addStreamingsMigrationUseCase =
      locator<AddStreamingsMigrationUseCase>();

  final StreamController<MigrationStatus> _streamController =
      StreamController();

  Stream<MigrationStatus> get stream => _streamController.stream;
  Future<dynamic> Function() get close => _streamController.close;

  void initMigration() {
    _streamController.add(_migrationStatusState.migration);
    if (!isWeb) {
      final MobileDatabaseMigrationUseCase databaseMigrationUseCase =
          locator<MobileDatabaseMigrationUseCase>();
      _streamController.addStream(databaseMigrationUseCase()).then(
            (_) =>
                _streamController.addStream(_addStreamingsMigrationUseCase()),
          );
      return;
    }
    _streamController.addStream(_addStreamingsMigrationUseCase());
  }

  void updateStatus(MigrationStatus status) async {
    _migrationStatusState.saveStatus(status);
    if (status == MigrationStatus.complete) {
      await close();
    }
  }
}
