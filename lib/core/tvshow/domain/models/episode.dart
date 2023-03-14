// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/tvshow/data/transformers/converters.dart';

part 'episode.g.dart';

@JsonSerializable(includeIfNull: false)
class Episode {
  @JsonKey(name: 'air_date', fromJson: _fromJsonAirDate)
  DateTime? airDate;
  @JsonKey(ignore: true)
  List<Crew> crew;
  @JsonKey(name: 'episode_number')
  int episodeNumber;
  @JsonKey(name: 'guest_starts')
  List<GuestStar> guestStars;
  String name;
  String overview;
  int id;
  @JsonKey(name: 'production_code')
  String productionCode;
  @JsonKey(name: 'season_number')
  int seasonNumber;
  @JsonKey(name: 'still_path')
  String stillPath;
  @JsonKey(name: 'vote_average')
  double voteAverage;
  @JsonKey(name: 'vote_count')
  int voteCount;

  Episode({
    this.airDate,
    this.crew = const [],
    required this.episodeNumber,
    this.guestStars = const [],
    required this.name,
    this.overview = '',
    required this.id,
    this.productionCode = '',
    required this.seasonNumber,
    this.stillPath = '',
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  factory Episode.fromRawJson(String str) =>
      _$EpisodeFromJson(json.decode(str));
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
  String toRawJson() => json.encode(_$EpisodeToJson(this));

  Episode copyWith({
    DateTime? airDate,
    List<Crew>? crew,
    int? episodeNumber,
    List<GuestStar>? guestStars,
    String? name,
    String? overview,
    int? id,
    String? productionCode,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
  }) {
    return Episode(
      airDate: airDate ?? this.airDate,
      crew: crew ?? this.crew,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      guestStars: guestStars ?? this.guestStars,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      id: id ?? this.id,
      productionCode: productionCode ?? this.productionCode,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  static DateTime? _fromJsonAirDate(String? airDate) {
    return Converters.fromJsonDate(airDate);
  }
}

@JsonSerializable(includeIfNull: false)
class Crew {
  int id;
  String creditId;
  String name;
  Department? department;
  Job? job;
  String profilePath;

  Crew({
    required this.id,
    this.creditId = '',
    this.name = '',
    this.department,
    this.job,
    this.profilePath = '',
  });

  factory Crew.fromRawJson(String str) => _$CrewFromJson(json.decode(str));
  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
  String toRawJson() => json.encode(_$CrewToJson(this));
}

enum Department { Directing, Camera, Editing, Writing }

enum Job { Director, Director_of_photography, Editor, Writer }

@JsonSerializable(includeIfNull: false)
class GuestStar {
  int id;
  String name;
  String creditId;
  String character;
  int? order;
  String profilePath;

  GuestStar({
    required this.id,
    this.name = '',
    this.creditId = '',
    this.character = '',
    this.order,
    this.profilePath = '',
  });

  factory GuestStar.fromRawJson(String str) =>
      _$GuestStarFromJson(json.decode(str));
  factory GuestStar.fromJson(Map<String, dynamic> json) =>
      _$GuestStarFromJson(json);

  Map<String, dynamic> toJson() => _$GuestStarToJson(this);
  String toRawJson() => json.encode(_$GuestStarToJson(this));
}
