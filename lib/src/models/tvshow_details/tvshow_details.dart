import 'dart:convert';

class TvshowDetails {
  List<int> episodeRunTime;
  int id;
  bool inProduction;
  String name;
  int numberOfEpisodes;
  int numberOfSeasons;
  String overview;
  String posterPath;
  List<Season> seasons;

  TvshowDetails({
    this.episodeRunTime,
    this.id,
    this.inProduction,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.overview,
    this.posterPath,
    this.seasons,
  });

  factory TvshowDetails.fromRawJson(String str) => TvshowDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvshowDetails.fromJson(Map<String, dynamic> json) => TvshowDetails(
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        id: json["id"],
        inProduction: json["in_production"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "id": id,
        "in_production": inProduction,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "overview": overview,
        "poster_path": posterPath,
      };
}

class Season {
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Season({
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  factory Season.fromRawJson(String str) => Season.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}
