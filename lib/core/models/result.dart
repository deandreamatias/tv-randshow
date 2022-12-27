import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../utils/converters.dart';

part 'result.g.dart';

@JsonSerializable(includeIfNull: false)
class Result {
  Result({
    this.posterPath = '',
    this.popularity,
    required this.id,
    this.backdropPath = '',
    this.voteAverage,
    this.overview = '',
    this.firstAirDate,
    this.originCountry = const [],
    this.genreIds = const [],
    this.originalLanguage = '',
    this.voteCount,
    this.name = '',
    this.originalName = '',
  });

  factory Result.fromRawJson(String str) => _$ResultFromJson(json.decode(str));
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  @JsonKey(name: 'poster_path')
  String posterPath;
  double? popularity;
  int id;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;
  @JsonKey(name: 'voter_average')
  double? voteAverage;
  String overview;
  @JsonKey(name: 'first_air_date', fromJson: _fromJsonFirstAirDate)
  DateTime? firstAirDate;
  @JsonKey(name: 'origin_country')
  List<String> originCountry;
  @JsonKey(name: 'genre_ids')
  List<int> genreIds;
  @JsonKey(name: 'original_language')
  String originalLanguage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  String name;
  @JsonKey(name: 'original_name')
  String originalName;

  Map<String, dynamic> toJson() => _$ResultToJson(this);
  String toRawJson() => json.encode(_$ResultToJson(this));

  static DateTime? _fromJsonFirstAirDate(String? firstAirDate) {
    return Converters.fromJsonDate(firstAirDate);
  }
}
