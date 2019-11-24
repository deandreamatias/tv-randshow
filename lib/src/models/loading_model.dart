import 'dart:math';

import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';
import 'package:tv_randshow/src/data/tvshow_seasons_details.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class LoadingModel extends BaseModel {
  Future<TvshowResult> getEpisode(TvshowDetails tvshowDetails) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey};
    var randomSeason = _getRandomNumber(tvshowDetails.numberOfSeasons, true);
    var data = await fetchData(
        Url.TVSHOW_DETAILS +
            tvshowDetails.id.toString() +
            Url.TVSHOW_DETAILS_SEASON +
            randomSeason.toString(),
        queryParameters);
    var tvshowSeasonDetails = TvshowSeasonsDetails.fromRawJson(data);
    var episode = tvshowSeasonDetails.episodes.elementAt(
        _getRandomNumber(tvshowSeasonDetails.episodes.length, false));
    setInit();
    final tvshowResult = TvshowResult(
        tvshowDetails: tvshowDetails,
        randomSeason: episode.seasonNumber,
        randomEpisode: episode.episodeNumber,
        episodeName: episode.name,
        episodeDescription: episode.overview);
    return tvshowResult;
  }

  /// If total is a number from 1, add + 1 to result.
  /// If else a length of list, get normal random
  int _getRandomNumber(int total, bool isSeason) {
    var random = Random();
    var randomNumber = random.nextInt(total);
    print('Random number nº: $randomNumber');
    return isSeason ? randomNumber + 1 : randomNumber;
  }
}
