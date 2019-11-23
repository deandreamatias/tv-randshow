import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/src/data/episode.dart';

part 'tvshow_seasons_details.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class TvshowSeasonsDetails {
  int id;
  @JsonKey(name: 'air_date')
  DateTime airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int tvshowSeasonsDetailsId;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'season_number')
  int seasonNumber;

  TvshowSeasonsDetails({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.tvshowSeasonsDetailsId,
    this.posterPath,
    this.seasonNumber,
  });

  factory TvshowSeasonsDetails.fromRawJson(String str) =>
      _$TvshowSeasonsDetailsFromJson(json.decode(str));
  factory TvshowSeasonsDetails.fromJson(Map<String, dynamic> json) =>
      _$TvshowSeasonsDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$TvshowSeasonsDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowSeasonsDetailsToJson(this));
}
