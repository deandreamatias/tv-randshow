import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'season.dart';

part 'tvshow_details.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class TvshowDetails {
  TvshowDetails({
    this.rowId,
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

  factory TvshowDetails.fromRawJson(String str) =>
      _$TvshowDetailsFromJson(json.decode(str));
  factory TvshowDetails.fromJson(Map<String, dynamic> json) =>
      _$TvshowDetailsFromJson(json);

  int rowId;
  @JsonKey(name: 'episode_run_time')
  List<int> episodeRunTime;
  int id;
  @JsonKey(name: 'in_production')
  dynamic inProduction;
  String name;
  @JsonKey(name: 'number_of_episodes')
  int numberOfEpisodes;
  @JsonKey(name: 'number_of_seasons')
  int numberOfSeasons;
  String overview;
  @JsonKey(name: 'poster_path')
  String posterPath;
  List<Season> seasons;

  Map<String, dynamic> toJson() => _$TvshowDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowDetailsToJson(this));
}
