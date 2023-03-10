class TvshowResult {
  final int id;
  final String name;
  final int randomSeason;
  final int randomEpisode;
  final String episodeName;
  final String episodeDescription;

  TvshowResult({
    required this.id,
    this.name = '',
    required this.randomSeason,
    required this.randomEpisode,
    required this.episodeName,
    this.episodeDescription = '',
  });
}
