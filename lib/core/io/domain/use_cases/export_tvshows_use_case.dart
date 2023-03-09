import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_permissions_service.dart';
import 'package:tv_randshow/core/io/domain/models/io_expections.dart';
import 'package:tv_randshow/core/io/domain/models/tvshows_file.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';

@injectable
class ExportTvShowsUseCase {
  final ILocalRepository _localRepository;
  final IManageFilesService _manageFilesService;
  final IPermissionsService _permissionsService;

  const ExportTvShowsUseCase(
    this._localRepository,
    this._manageFilesService,
    this._permissionsService,
  );

  Future<bool> call() async {
    if (!(await _permissionsService.getStoragePermission())) return false;

    final favTvshows = await _localRepository.getTvshows();
    if (favTvshows.isEmpty) throw IoExpection('No tvshows');

    final jsonFavTvshows = TvshowsFile(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';

    final downloadPath =
        await _manageFilesService.saveFile(fileName, jsonFavTvshows);

    return downloadPath.isNotEmpty;
  }
}
