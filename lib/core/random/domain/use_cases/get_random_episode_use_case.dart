import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class GetRandomEpisodeUseCase {
  final IOnlineRepository _onlineRepository;
  final IRandomService _randomService;

  const GetRandomEpisodeUseCase(this._onlineRepository, this._randomService);

  Future<TvshowResult> call({
    required int idTv,
    required int numberOfSeasons,
  }) async {
    if (numberOfSeasons <= 0) {
      throw const AppError(
        code: AppErrorCode.invalidSeasonNumber,
        message: 'Invalid numberOfSeasons. Should be bigger than 0',
      );
    }
    // When has only one season, do not need get random season.
    final int randomSeason = numberOfSeasons == 1
        ? 1
        : _randomService.getNumber(max: numberOfSeasons, min: 1);
    final TvshowSeasonsDetails seasonsDetails =
        await _onlineRepository.getDetailsTvSeasons(
      Helpers.getLocale(),
      idTv,
      randomSeason,
    );
    // Get random episode.
    final episodeIndex =
        _randomService.getNumber(max: seasonsDetails.episodes.length);
    final Episode episode = seasonsDetails.episodes.elementAt(episodeIndex);

    // Verify result values and throw error if incorrect.
    if (episode.seasonNumber <= 0) {
      throw const AppError(
        code: AppErrorCode.invalidSeasonNumber,
        message: 'Invalid seasonNumber result. Should be bigger than 0',
      );
    }
    if (episode.episodeNumber <= 0) {
      throw const AppError(
        code: AppErrorCode.invalidEpisodeNumber,
        message: 'Invalid episodeNumber result. Should be bigger than 0',
      );
    }

    return TvshowResult(
      id: episode.id,
      name: seasonsDetails.name,
      randomSeason: episode.seasonNumber,
      randomEpisode: episode.episodeNumber,
      episodeName: episode.name,
      episodeDescription: episode.overview,
    );
  }
}
