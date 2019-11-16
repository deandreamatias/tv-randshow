import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class Episode {
  @JsonKey(name: 'air_date')
  DateTime airDate;
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
    this.crew,
    this.episodeNumber,
    this.guestStars,
    this.name,
    this.overview,
    this.id,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory Episode.fromRawJson(String str) => _$EpisodeFromJson(json.decode(str));
  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
  String toRawJson() => json.encode(_$EpisodeToJson(this));
}

@JsonSerializable(nullable: true, includeIfNull: false)
class Crew {
  int id;
  String creditId;
  String name;
  Department department;
  Job job;
  String profilePath;

  Crew({
    this.id,
    this.creditId,
    this.name,
    this.department,
    this.job,
    this.profilePath,
  });

  factory Crew.fromRawJson(String str) => _$CrewFromJson(json.decode(str));
  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
  Map<String, dynamic> toJson() => _$CrewToJson(this);
  String toRawJson() => json.encode(_$CrewToJson(this));
}

enum Department { DIRECTING, CAMERA, EDITING, WRITING }

final departmentValues = EnumValues({
  "Camera": Department.CAMERA,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Writing": Department.WRITING
});

enum Job { DIRECTOR, DIRECTOR_OF_PHOTOGRAPHY, EDITOR, WRITER }

final jobValues = EnumValues({
  "Director": Job.DIRECTOR,
  "Director of Photography": Job.DIRECTOR_OF_PHOTOGRAPHY,
  "Editor": Job.EDITOR,
  "Writer": Job.WRITER
});

@JsonSerializable(nullable: true, includeIfNull: false)
class GuestStar {
  int id;
  String name;
  String creditId;
  String character;
  int order;
  String profilePath;

  GuestStar({
    this.id,
    this.name,
    this.creditId,
    this.character,
    this.order,
    this.profilePath,
  });

  factory GuestStar.fromRawJson(String str) => _$GuestStarFromJson(json.decode(str));
  factory GuestStar.fromJson(Map<String, dynamic> json) => _$GuestStarFromJson(json);
  Map<String, dynamic> toJson() => _$GuestStarToJson(this);
  String toRawJson() => json.encode(_$GuestStarToJson(this));
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
