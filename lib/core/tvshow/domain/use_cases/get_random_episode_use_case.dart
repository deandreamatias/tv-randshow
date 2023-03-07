import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/tvshow/domain/services/random_service.dart';

@injectable
class GetRandomEpisodeUseCase {
  final IOnlineRepository _onlineRepository;
  final RandomService _randomService;

  const GetRandomEpisodeUseCase(this._onlineRepository, this._randomService);

  Future<TvshowResult> call({
    required TvshowDetails tvshowDetails,
    required String language,
  }) async {
    final int randomSeason =
        _randomService.getNumber(max: tvshowDetails.numberOfSeasons, min: 1);
    final TvshowSeasonsDetails seasonsDetails =
        await _onlineRepository.getDetailsTvSeasons(
      language,
      tvshowDetails.id,
      randomSeason,
    );
    final Episode episode = seasonsDetails.episodes.elementAt(
      _randomService.getNumber(max: seasonsDetails.episodes.length),
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
