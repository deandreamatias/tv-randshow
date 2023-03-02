import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/migration/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';

@injectable
class SaveMigrationStatusUseCase {
  final IMigrationRepository _migrationRepository;

  SaveMigrationStatusUseCase(this._migrationRepository);

  Future<bool> call(MigrationStatus status) async {
    return _migrationRepository.saveStatus(status);
  }
}
