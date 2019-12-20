import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'season.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class Season {
  Season({
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  factory Season.fromRawJson(String str) => _$SeasonFromJson(json.decode(str));
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  
  @JsonKey(name: 'episode_count')
  int episodeCount;
  int id;
  String name;
  String overview;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'season_number')
  int seasonNumber;

  Map<String, dynamic> toJson() => _$SeasonToJson(this);
  String toRawJson() => json.encode(_$SeasonToJson(this));
}
