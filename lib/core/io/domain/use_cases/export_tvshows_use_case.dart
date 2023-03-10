import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';
import 'package:tv_randshow/core/io/domain/models/io_expection.dart';
import 'package:tv_randshow/core/io/domain/models/tvshows_file.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';

@injectable
class ExportTvShowsUseCase {
  final ILocalRepository _localRepository;
  final IManageFilesService _manageFilesService;

  const ExportTvShowsUseCase(
    this._localRepository,
    this._manageFilesService,
  );

  Future<bool> call() async {
    final favTvshows = await _localRepository.getTvshows();
    if (favTvshows.isEmpty) throw IoExpection('No tvshows');

    final jsonFavTvshows = TvshowsFile(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime.first}';

    final downloadPath =
        await _manageFilesService.saveFile(fileName, jsonFavTvshows);

    return downloadPath.isNotEmpty;
  }
}
