import 'dart:math';

import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/data/tvshow_seasons_details.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class LoadingModel extends BaseModel {
  Future<void> getEpisode(TvshowDetails tvshowDetails) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey};
    var randomSeason = getRandomNumber(tvshowDetails.numberOfSeasons);
    var data = await fetchData(
        Url.TVSHOW_DETAILS +
            tvshowDetails.id.toString() +
            Url.TVSHOW_DETAILS_SEASON +
            randomSeason.toString(),
        queryParameters);
    var tvshowSeasonDetails = TvshowSeasonsDetails.fromRawJson(data);
    var randomEpisode = getRandomNumber(tvshowSeasonDetails.episodes.length);
    setInit();
  }

  int getRandomNumber(int total) {
    var random = Random();
    var randomNumber = random.nextInt(total) + 1;
    print('Random number nº: $randomNumber');

    return randomNumber;
  }
}
