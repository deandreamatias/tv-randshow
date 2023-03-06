import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_tvshow_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/tvshow/domain/services/random_service.dart';

@injectable
class GetRandomEpisodeUseCase {
  final ITvshowRepository _tvshowRepository;
  final RandomService _randomService;

  const GetRandomEpisodeUseCase(this._tvshowRepository, this._randomService);

  Future<TvshowResult> call({
    required TvshowDetails tvshowDetails,
    required String language,
  }) async {
    final Query query = Query(language: language);
    final int randomSeason =
        _randomService.getNumber(tvshowDetails.numberOfSeasons, isSeason: true);
    final TvshowSeasonsDetails seasonsDetails =
        await _tvshowRepository.getDetailsTvSeasons(
      query,
      tvshowDetails.id,
      randomSeason,
    );
    final Episode episode = seasonsDetails.episodes.elementAt(
      _randomService.getNumber(seasonsDetails.episodes.length),
    );
    return TvshowResult(
      tvshowDetails: tvshowDetails,
      randomSeason: episode.seasonNumber,
      randomEpisode: episode.episodeNumber,
      episodeName: episode.name,
      episodeDescription: episode.overview,
    );
  }
}
