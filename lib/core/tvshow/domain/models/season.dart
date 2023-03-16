import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'season.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class Season {
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Season({
    this.episodeCount = 0,
    required this.id,
    this.name = '',
    this.overview = '',
    this.posterPath = '',
    this.seasonNumber = 0,
  });

  factory Season.fromRawJson(String str) => _$SeasonFromJson(json.decode(str));
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);
  String toRawJson() => json.encode(_$SeasonToJson(this));
}
