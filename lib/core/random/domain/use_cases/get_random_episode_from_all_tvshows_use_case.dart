import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';

@injectable
class GetRandomEpisodeFromAllTvshowsUseCase {
  final ILocalRepository _localRepository;
  final GetRandomEpisodeUseCase _getRandomEpisodeUseCase;
  final IRandomService _randomService;

  const GetRandomEpisodeFromAllTvshowsUseCase(
    this._localRepository,
    this._getRandomEpisodeUseCase,
    this._randomService,
  );

  Future<TvshowResult> call() async {
    final tvshows = await _localRepository.getTvshows();

    if (tvshows.isEmpty) {
      throw const AppError(
        code: AppErrorCode.emptyFavs,
        message: 'No tv shows on local repository to get random episode',
      );
    }

    final tvshowIndex = _randomService.getNumber(max: tvshows.length);

    return _getRandomEpisodeUseCase(idTv: tvshows[tvshowIndex].id);
  }
}
