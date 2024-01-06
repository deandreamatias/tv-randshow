import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/data/repositories/local_repository.dart';

part 'tvshow_details.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
@HiveType(typeId: tvshowDetailsHiveTypeId)
class TvshowDetails extends HiveObject {
  @HiveField(0)
  int? rowId;

  @HiveField(1)
  List<int> episodeRunTime;

  @HiveField(2)
  int id;

  @HiveField(3)
  // Undefined parameter from api.
  // ignore: avoid-dynamic
  dynamic inProduction;

  @HiveField(4)
  String name;
  @HiveField(5)
  int numberOfEpisodes;
  @HiveField(6)
  int numberOfSeasons;

  @HiveField(7)
  String overview;

  @HiveField(8)
  String posterPath;

  @JsonKey(includeFromJson: false, includeToJson: false)
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
