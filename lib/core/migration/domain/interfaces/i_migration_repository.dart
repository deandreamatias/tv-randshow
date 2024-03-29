import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';

abstract class IMigrationRepository {
  Future<bool> saveStatus(MigrationStatus status);
  Future<MigrationStatus> getStatus();
}
