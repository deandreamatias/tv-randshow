import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/data/repositories/hive_local_repository.dart';

part 'tvshow_details.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: tvshowDetailsHiveTypeId)
class TvshowDetails extends HiveObject {
  @HiveField(0)
  int? rowId;

  @JsonKey(name: 'episode_run_time')
  @HiveField(1)
  List<int> episodeRunTime;

  @HiveField(2)
  int id;

  @JsonKey(name: 'in_production')
  @HiveField(3)
  // Undefined parameter from api.
  // ignore: avoid-dynamic
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

  @JsonKey(ignore: true)
  List<StreamingDetail> streamings;
  TvshowDetails({
    this.rowId,
    this.episodeRunTime = const [],
    required this.id,
    this.inProduction,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    this.overview = '',
    this.posterPath = '',
    this.streamings = const [],
  });

  factory TvshowDetails.fromRawJson(String str) =>
      _$TvshowDetailsFromJson(json.decode(str));
  factory TvshowDetails.fromJson(Map<String, dynamic> json) =>
      _$TvshowDetailsFromJson(json);

  TvshowDetails copyWith({
    int? rowId,
    List<int>? episodeRunTime,
    int? id,
    inProduction,
    String? name,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    String? overview,
    String? posterPath,
    List<StreamingDetail>? streamings,
  }) =>
      TvshowDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
        numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
        episodeRunTime: episodeRunTime ?? this.episodeRunTime,
        inProduction: inProduction ?? this.inProduction,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        rowId: rowId ?? this.rowId,
        streamings: streamings ?? this.streamings,
      );

  Map<String, dynamic> toJson() => _$TvshowDetailsToJson(this);
  String toRawJson() => json.encode(_$TvshowDetailsToJson(this));
}
