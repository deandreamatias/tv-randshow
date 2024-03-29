import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/app/data/transformers/date_time_transformer.dart';

part 'result.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
@DateTimeTransformer()
class Result {
  @JsonKey(name: 'poster_path')
  String posterPath;
  double? popularity;
  int id;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;
  @JsonKey(name: 'voter_average')
  double? voteAverage;
  String overview;
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

  bool get isOnAir => firstAirDate != null;

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

  Map<String, dynamic> toJson() => _$ResultToJson(this);
  String toRawJson() => json.encode(_$ResultToJson(this));
}
