import 'dart:convert';

class TvshowSearch {
  int page;
  List<Result> results;
  int totalResults;
  int totalPages;

  TvshowSearch({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory TvshowSearch.fromRawJson(String str) => TvshowSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvshowSearch.fromJson(Map<String, dynamic> json) => TvshowSearch(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Result {
  String posterPath;
  double popularity;
  int id;
  String backdropPath;
  double voteAverage;
  String overview;
  DateTime firstAirDate;
  List<String> originCountry;
  List<int> genreIds;
  String originalLanguage;
  int voteCount;
  String name;
  String originalName;

  Result({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };
}
