import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

class TvshowResult {
  final String name;
  final int randomSeason;
  final int randomEpisode;
  final String image;
  final String episodeName;
  final String episodeDescription;
  final List<StreamingDetail> streamings;

  TvshowResult({
    this.name = '',
    required this.image,
    required this.randomSeason,
    required this.randomEpisode,
    required this.episodeName,
    this.episodeDescription = '',
    this.streamings = const [],
  });
}
