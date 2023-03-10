import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/interfaces/i_local_preferences_service.dart';
import 'package:tv_randshow/core/migration/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';

@Injectable(as: IMigrationRepository)
class MigrationRepository implements IMigrationRepository {
  final String keyStatus = 'status';
  final ILocalPreferencesService _localStorageService;
  MigrationRepository(this._localStorageService);

  @override
  Future<bool> saveStatus(MigrationStatus status) async {
    return _localStorageService.write<int>(
      key: keyStatus,
      value: status.getOrder(),
    );
  }

  @override
  Future<MigrationStatus> getStatus() async {
    final status = await _localStorageService.read<int>(key: keyStatus);

    return status?.getStatus() ?? MigrationStatus.init;
  }
}
