import 'dart:convert';

class TvshowDetails {
  String backdropPath;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  LastEpisodeToAir lastEpisodeToAir;
  String name;
  dynamic nextEpisodeToAir;
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<Network> productionCompanies;
  List<Season> seasons;
  String status;
  String type;
  double voteAverage;
  int voteCount;

  TvshowDetails({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.seasons,
    this.status,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory TvshowDetails.fromRawJson(String str) => TvshowDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvshowDetails.fromJson(Map<String, dynamic> json) => TvshowDetails(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies:
            List<Network>.from(json["production_companies"].map((x) => Network.fromJson(x))),
        seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        status: json["status"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "status": status,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class CreatedBy {
  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };
}

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class LastEpisodeToAir {
  DateTime airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory LastEpisodeToAir.fromRawJson(String str) => LastEpisodeToAir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => LastEpisodeToAir(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Network {
  String name;
  int id;
  String logoPath;
  String originCountry;

  Network({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  factory Network.fromRawJson(String str) => Network.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry,
      };
}

class Season {
  DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Season({
    this.airDate,
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
        airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}
