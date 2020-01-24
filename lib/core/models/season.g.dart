// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return Season(
    episodeCount: json['episode_count'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    overview: json['overview'] as String,
    posterPath: json['poster_path'] as String,
    seasonNumber: json['season_number'] as int,
  );
}

Map<String, dynamic> _$SeasonToJson(Season instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('episode_count', instance.episodeCount);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('overview', instance.overview);
  writeNotNull('poster_path', instance.posterPath);
  writeNotNull('season_number', instance.seasonNumber);
  return val;
}
