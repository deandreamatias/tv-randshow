import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'season.dart';

part 'tvshow_details.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 1)
class TvshowDetails extends HiveObject {
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

  @HiveField(0)
  int rowId;
  @JsonKey(name: 'episode_run_time')
  @HiveField(1)
  List<int> episodeRunTime;
  @HiveField(2)
  int id;
  @JsonKey(name: 'in_production')
  @HiveField(3)
  dynamic inProduction;
  @HiveField(4)
  String name;
  @JsonKey(name: 'number_of_episodes')
  @HiveField(5)
  int numberOfEpisodes;
  @JsonKey(name: 'number_of_seasons')
  @HiveField(6)
  int numberOfSeasons;
  @HiveField(7)
  String overview;
  @JsonKey(name: 'poster_path')
  @HiveField(8)
  String posterPath;
  List<Season> seasons;

  Map<String, dynamic> toJson() => _$TvshowDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowDetailsToJson(this));
}
