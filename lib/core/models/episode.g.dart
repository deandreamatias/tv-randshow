// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      airDate: json['air_date'] == null
          ? null
          : DateTime.parse(json['air_date'] as String),
      episodeNumber: json['episode_number'] as int,
      guestStars: (json['guest_starts'] as List<dynamic>?)
              ?.map((e) => GuestStar.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      name: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      id: json['id'] as int,
      productionCode: json['production_code'] as String? ?? '',
      seasonNumber: json['season_number'] as int,
      stillPath: json['still_path'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('air_date', instance.airDate?.toIso8601String());
  val['episode_number'] = instance.episodeNumber;
  val['guest_starts'] = instance.guestStars;
  val['name'] = instance.name;
  val['overview'] = instance.overview;
  val['id'] = instance.id;
  val['production_code'] = instance.productionCode;
  val['season_number'] = instance.seasonNumber;
  val['still_path'] = instance.stillPath;
  val['vote_average'] = instance.voteAverage;
  val['vote_count'] = instance.voteCount;
  return val;
}

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      id: json['id'] as int,
      creditId: json['creditId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      department: $enumDecodeNullable(_$DepartmentEnumMap, json['department']),
      job: $enumDecodeNullable(_$JobEnumMap, json['job']),
      profilePath: json['profilePath'] as String? ?? '',
    );

Map<String, dynamic> _$CrewToJson(Crew instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'creditId': instance.creditId,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('department', _$DepartmentEnumMap[instance.department]);
  writeNotNull('job', _$JobEnumMap[instance.job]);
  val['profilePath'] = instance.profilePath;
  return val;
}

const _$DepartmentEnumMap = {
  Department.Directing: 'Directing',
  Department.Camera: 'Camera',
  Department.Editing: 'Editing',
  Department.Writing: 'Writing',
};

const _$JobEnumMap = {
  Job.Director: 'Director',
  Job.Director_of_photography: 'Director_of_photography',
  Job.Editor: 'Editor',
  Job.Writer: 'Writer',
};

GuestStar _$GuestStarFromJson(Map<String, dynamic> json) => GuestStar(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      creditId: json['creditId'] as String? ?? '',
      character: json['character'] as String? ?? '',
      order: json['order'] as int?,
      profilePath: json['profilePath'] as String? ?? '',
    );

Map<String, dynamic> _$GuestStarToJson(GuestStar instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'creditId': instance.creditId,
    'character': instance.character,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('order', instance.order);
  val['profilePath'] = instance.profilePath;
  return val;
}
