import 'dart:math';

import 'package:tv_randshow/src/data/episode.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';
import 'package:tv_randshow/src/data/tvshow_seasons_details.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class LoadingModel extends BaseModel {
  Future<TvshowResult> getEpisode(TvshowDetails tvshowDetails) async {
    setLoading();
    await checkConnection();
    if (hasConnection) {
      final String apiKey = await secureStorage.readStorage(KeyStore.API_KEY);
      final Map<String, String> queryParameters = <String, String>{
        'api_key': apiKey
      };
      final int randomSeason =
          _getRandomNumber(tvshowDetails.numberOfSeasons, true);
      final String data = await fetchData(
          TVSHOW_DETAILS +
              tvshowDetails.id.toString() +
              TVSHOW_DETAILS_SEASON +
              randomSeason.toString(),
          queryParameters);
      if (data != null && data.isNotEmpty) {
        final TvshowSeasonsDetails tvshowSeasonDetails =
            TvshowSeasonsDetails.fromRawJson(data);
        final Episode episode = tvshowSeasonDetails.episodes.elementAt(
            _getRandomNumber(tvshowSeasonDetails.episodes.length, false));

        final TvshowResult tvshowResult = TvshowResult(
            tvshowDetails: tvshowDetails,
            randomSeason: episode.seasonNumber,
            randomEpisode: episode.episodeNumber,
            episodeName: episode.name,
            episodeDescription: episode.overview);
        setInit();
        return tvshowResult;
      } else {
        setError();
        return null;
      }
    } else {
      setError();
      return null;
    }
  }

  /// If total is a number from 1, add + 1 to result.
  /// If else a length of list, get normal random
  int _getRandomNumber(int total, bool isSeason) {
    final Random random = Random();
    final int randomNumber = random.nextInt(total);
    logger.printDebug('Random number nº: $randomNumber');
    return isSeason ? randomNumber + 1 : randomNumber;
  }
}
