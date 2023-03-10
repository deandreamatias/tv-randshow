import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/migration/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';

@injectable
class SaveMigrationStatusUseCase {
  final IMigrationRepository _migrationRepository;

  SaveMigrationStatusUseCase(this._migrationRepository);

  Future<void> call(MigrationStatus status) {
    return _migrationRepository.saveStatus(status);
  }
}
