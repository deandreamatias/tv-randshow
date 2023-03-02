import 'package:tv_randshow/core/models/tvshow_details.dart';

class TvshowResult {
  TvshowResult({
    required this.tvshowDetails,
    required this.randomSeason,
    required this.randomEpisode,
    required this.episodeName,
    required this.episodeDescription,
  });

  TvshowDetails tvshowDetails;
  int randomSeason;
  int randomEpisode;
  String episodeName;
  String episodeDescription;
}
