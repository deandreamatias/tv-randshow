import 'package:tv_randshow/src/data/tvshow_details.dart';

class TvshowResult {
  TvshowDetails tvshowDetails;
  int randomSeason;
  int randomEpisode;
  String episodeName;
  String episodeDescription;

  TvshowResult(
      {this.tvshowDetails,
      this.randomSeason,
      this.randomEpisode,
      this.episodeName,
      this.episodeDescription});
}
