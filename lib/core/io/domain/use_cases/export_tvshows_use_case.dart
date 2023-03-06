import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/io/domain/interfaces/manage_files_service.dart';
import 'package:tv_randshow/core/io/domain/interfaces/permissions_service.dart';
import 'package:tv_randshow/core/io/domain/models/tvshows_file.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_database_repository.dart';

@injectable
class ExportTvShowsUseCase {
  final IDatabaseRepository _databaseRepository;
  final IManageFilesService _filesService;
  final IPermissionsService _permissionsService;

  const ExportTvShowsUseCase(
    this._databaseRepository,
    this._filesService,
    this._permissionsService,
  );

  Future<bool> call() async {
    if (!(await _permissionsService.getStoragePermission())) return false;

    final favTvshows = await _databaseRepository.getTvshows();
    if (favTvshows.isEmpty) return false;

    final jsonFavTvshows = TvshowsFile(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';

    final downloadPath = await _filesService.saveFile(fileName, jsonFavTvshows);

    return downloadPath.isNotEmpty;
  }
}
