import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_tvshow_seasons_details_use_case.dart';

@injectable
class GetRandomEpisodeUseCase {
  final ILocalRepository _localRepository;
  final IRandomService _randomService;
  final GetTvshowSeasonsDetailsUseCase _seasonsDetailsUseCase;

  const GetRandomEpisodeUseCase(
    this._localRepository,
    this._randomService,
    this._seasonsDetailsUseCase,
  );

  Future<TvshowResult> call({required int idTv}) async {
    // Get local tvshow.
    final tvshow = await _localRepository.getTvshow(idTv);
    if (tvshow.numberOfSeasons <= 0) {
      throw const AppError(
        code: AppErrorCode.invalidSeasonNumber,
        message: 'Invalid numberOfSeasons. Should be bigger than 0',
      );
    }

    // Get random season.
    // When has only one season, do not need get random season.
    final int randomSeason = tvshow.numberOfSeasons == 1
        ? 1
        : _randomService.getNumber(max: tvshow.numberOfSeasons, min: 1);
    final TvshowSeasonsDetails seasonsDetails = await _seasonsDetailsUseCase(
      idTv: idTv,
      season: randomSeason,
    );

    // Get random episode.
    final episodeIndex = _randomService.getNumber(
      max: seasonsDetails.episodes.length,
    );
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
      name: tvshow.name,
      image: tvshow.posterPath,
      randomSeason: episode.seasonNumber,
      randomEpisode: episode.episodeNumber,
      episodeName: episode.name,
      episodeDescription: episode.overview,
      streamings: tvshow.streamings,
    );
  }
}
