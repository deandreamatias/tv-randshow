import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'episode.dart';

part 'tvshow_seasons_details.g.dart';

@JsonSerializable(includeIfNull: false)
class TvshowSeasonsDetails {
  const TvshowSeasonsDetails({
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

  final int id;
  @JsonKey(name: 'air_date', fromJson: _fromJsonAirDate)
  final DateTime? airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int? tvshowSeasonsDetailsId;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'season_number')
  final int seasonNumber;

  Map<String, dynamic> toJson() => _$TvshowSeasonsDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowSeasonsDetailsToJson(this));

  static DateTime? _fromJsonAirDate(Map<String, dynamic> json) {
    json['air_date'] == null || (json['air_date'] as String).isEmpty
        ? null
        : DateTime.parse(json['air_date'] as String);
  }
}
