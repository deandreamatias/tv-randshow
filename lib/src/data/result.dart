import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class Result {
  @JsonKey(name: 'poster_path')
  String posterPath;
  double popularity;
  int id;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;
  @JsonKey(name: 'voter_average')
  double voteAverage;
  String overview;
  @JsonKey(name: 'first_air_date')
  DateTime firstAirDate;
  @JsonKey(name: 'origin_country')
  List<String> originCountry;
  @JsonKey(name: 'genre_ids')
  List<int> genreIds;
  @JsonKey(name: 'original_language')
  String originalLanguage;
  @JsonKey(name: 'vote_count')
  int voteCount;
  String name;
  @JsonKey(name: 'original_name')
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

  factory Result.fromRawJson(String str) => _$ResultFromJson(json.decode(str));
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
  String toRawJson() => json.encode(_$ResultToJson(this));
}
