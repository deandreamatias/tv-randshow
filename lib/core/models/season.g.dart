// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      episodeCount: json['episode_count'] as int? ?? 0,
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      seasonNumber: json['season_number'] as int? ?? 0,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'episode_count': instance.episodeCount,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
    };
