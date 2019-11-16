import 'dart:convert';

class TvshowSeasonsDetails {
  String id;
  DateTime airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int tvshowSeasonsDetailsId;
  String posterPath;
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
      TvshowSeasonsDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvshowSeasonsDetails.fromJson(Map<String, dynamic> json) => TvshowSeasonsDetails(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        tvshowSeasonsDetailsId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": tvshowSeasonsDetailsId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}

class Episode {
  DateTime airDate;
  List<Crew> crew;
  int episodeNumber;
  List<GuestStar> guestStars;
  String name;
  String overview;
  int id;
  String productionCode;
  int seasonNumber;
  String stillPath;
  double voteAverage;
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

  factory Episode.fromRawJson(String str) => Episode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: DateTime.parse(json["air_date"]),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        episodeNumber: json["episode_number"],
        guestStars: List<GuestStar>.from(json["guest_stars"].map((x) => GuestStar.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "episode_number": episodeNumber,
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

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

  factory Crew.fromRawJson(String str) => Crew.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        department: departmentValues.map[json["department"]],
        job: jobValues.map[json["job"]],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "department": departmentValues.reverse[department],
        "job": jobValues.reverse[job],
        "profile_path": profilePath == null ? null : profilePath,
      };
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

  factory GuestStar.fromRawJson(String str) => GuestStar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GuestStar.fromJson(Map<String, dynamic> json) => GuestStar(
        id: json["id"],
        name: json["name"],
        creditId: json["credit_id"],
        character: json["character"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "credit_id": creditId,
        "character": character,
        "order": order,
        "profile_path": profilePath,
      };
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
