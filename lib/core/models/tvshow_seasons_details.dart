import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'episode.dart';

part 'tvshow_seasons_details.g.dart';

@JsonSerializable(includeIfNull: false)
class TvshowSeasonsDetails {
  TvshowSeasonsDetails({
    required this.id,
    this.airDate,
    this.episodes = const [],
    this.name = '',
    this.overview = '',
    this.tvshowSeasonsDetailsId,
    this.posterPath = '',
    required this.seasonNumber,
  });

  factory TvshowSeasonsDetails.fromRawJson(String str) =>
      _$TvshowSeasonsDetailsFromJson(json.decode(str));
  factory TvshowSeasonsDetails.fromJson(Map<String, dynamic> json) =>
      _$TvshowSeasonsDetailsFromJson(json);

  int id;
  @JsonKey(name: 'air_date')
  DateTime? airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int? tvshowSeasonsDetailsId;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'season_number')
  int seasonNumber;

  Map<String, dynamic> toJson() => _$TvshowSeasonsDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowSeasonsDetailsToJson(this));
}
