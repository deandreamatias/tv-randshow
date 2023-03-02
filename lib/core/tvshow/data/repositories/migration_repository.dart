import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/data/services/local_storage_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_migration_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';

@Injectable(as: IMigrationRepository)
class MigrationRepository implements IMigrationRepository {
  final LocalStorageService _localStorageService;
  final String keyStatus = 'status';
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
