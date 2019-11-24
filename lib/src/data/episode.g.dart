// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    airDate: json['air_date'] == null
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodeNumber: json['episode_number'] as int,
    guestStars: (json['guest_starts'] as List)
        ?.map((e) =>
            e == null ? null : GuestStar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    name: json['name'] as String,
    overview: json['overview'] as String,
    id: json['id'] as int,
    productionCode: json['production_code'] as String,
    seasonNumber: json['season_number'] as int,
    stillPath: json['still_path'] as String,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    voteCount: json['vote_count'] as int,
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('air_date', instance.airDate?.toIso8601String());
  writeNotNull('episode_number', instance.episodeNumber);
  writeNotNull('guest_starts', instance.guestStars);
  writeNotNull('name', instance.name);
  writeNotNull('overview', instance.overview);
  writeNotNull('id', instance.id);
  writeNotNull('production_code', instance.productionCode);
  writeNotNull('season_number', instance.seasonNumber);
  writeNotNull('still_path', instance.stillPath);
  writeNotNull('vote_average', instance.voteAverage);
  writeNotNull('vote_count', instance.voteCount);
  return val;
}

Crew _$CrewFromJson(Map<String, dynamic> json) {
  return Crew(
    id: json['id'] as int,
    creditId: json['creditId'] as String,
    name: json['name'] as String,
    department: _$enumDecodeNullable(_$DepartmentEnumMap, json['department']),
    job: _$enumDecodeNullable(_$JobEnumMap, json['job']),
    profilePath: json['profilePath'] as String,
  );
}

Map<String, dynamic> _$CrewToJson(Crew instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('creditId', instance.creditId);
  writeNotNull('name', instance.name);
  writeNotNull('department', _$DepartmentEnumMap[instance.department]);
  writeNotNull('job', _$JobEnumMap[instance.job]);
  writeNotNull('profilePath', instance.profilePath);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DepartmentEnumMap = {
  Department.Directing: 'Directing',
  Department.Camera: 'Camera',
  Department.Editing: 'Editing',
  Department.Writing: 'Writing',
};

const _$JobEnumMap = {
  Job.Director: 'Director',
  Job.Director_of_photography: 'Director of photography',
  Job.Editor: 'Editor',
  Job.Writer: 'Writer',
};

GuestStar _$GuestStarFromJson(Map<String, dynamic> json) {
  return GuestStar(
    id: json['id'] as int,
    name: json['name'] as String,
    creditId: json['creditId'] as String,
    character: json['character'] as String,
    order: json['order'] as int,
    profilePath: json['profilePath'] as String,
  );
}

Map<String, dynamic> _$GuestStarToJson(GuestStar instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('creditId', instance.creditId);
  writeNotNull('character', instance.character);
  writeNotNull('order', instance.order);
  writeNotNull('profilePath', instance.profilePath);
  return val;
}
