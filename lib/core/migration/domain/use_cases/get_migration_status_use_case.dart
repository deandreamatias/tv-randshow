import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/migration/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';

@injectable
class GetMigrationStatusUseCase {
  final IMigrationRepository _migrationRepository;

  GetMigrationStatusUseCase(this._migrationRepository);

  Future<MigrationStatus> call() {
    return _migrationRepository.getStatus();
  }
}
