import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/tvshow/data/transformers/converters.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';

part 'tvshow_seasons_details.g.dart';

@JsonSerializable(includeIfNull: false)
class TvshowSeasonsDetails {
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

  Map<String, dynamic> toJson() => _$TvshowSeasonsDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowSeasonsDetailsToJson(this));

  TvshowSeasonsDetails copyWith({
    int? id,
    DateTime? airDate,
    List<Episode>? episodes,
    String? name,
    String? overview,
    int? tvshowSeasonsDetailsId,
    String? posterPath,
    int? seasonNumber,
  }) {
    return TvshowSeasonsDetails(
      id: id ?? this.id,
      airDate: airDate ?? this.airDate,
      episodes: episodes ?? this.episodes,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      tvshowSeasonsDetailsId:
          tvshowSeasonsDetailsId ?? this.tvshowSeasonsDetailsId,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
    );
  }

  static DateTime? _fromJsonAirDate(String? airDate) {
    return Converters.fromJsonDate(airDate);
  }
}
