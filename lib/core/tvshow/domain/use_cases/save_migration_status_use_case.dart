import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/tvshow/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';

@injectable
class SaveMigrationStatusUseCase {
  final IMigrationRepository _migrationRepository;

  SaveMigrationStatusUseCase(this._migrationRepository);

  Future<bool> call(MigrationStatus status) async {
    return await _migrationRepository.saveStatus(status);
  }
}
