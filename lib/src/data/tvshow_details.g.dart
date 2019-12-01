// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvshow_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvshowDetails _$TvshowDetailsFromJson(Map<String, dynamic> json) {
  return TvshowDetails(
    rowId: json['rowId'] as int,
    episodeRunTime:
        (json['episode_run_time'] as List)?.map((e) => e as int)?.toList(),
    id: json['id'] as int,
    inProduction: json['in_production'],
    name: json['name'] as String,
    numberOfEpisodes: json['number_of_episodes'] as int,
    numberOfSeasons: json['number_of_seasons'] as int,
    overview: json['overview'] as String,
    posterPath: json['poster_path'] as String,
    seasons: (json['seasons'] as List)
        ?.map((e) =>
            e == null ? null : Season.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TvshowDetailsToJson(TvshowDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rowId', instance.rowId);
  writeNotNull('episode_run_time', instance.episodeRunTime);
  writeNotNull('id', instance.id);
  writeNotNull('in_production', instance.inProduction);
  writeNotNull('name', instance.name);
  writeNotNull('number_of_episodes', instance.numberOfEpisodes);
  writeNotNull('number_of_seasons', instance.numberOfSeasons);
  writeNotNull('overview', instance.overview);
  writeNotNull('poster_path', instance.posterPath);
  writeNotNull('seasons', instance.seasons);
  return val;
}
