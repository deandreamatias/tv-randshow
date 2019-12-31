// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvshow_seasons_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvshowSeasonsDetails _$TvshowSeasonsDetailsFromJson(Map<String, dynamic> json) {
  return TvshowSeasonsDetails(
    id: json['id'] as int,
    airDate: json['air_date'] == null || json['air_date'].isEmpty
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodes: (json['episodes'] as List)
        ?.map((e) =>
            e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    name: json['name'] as String,
    overview: json['overview'] as String,
    tvshowSeasonsDetailsId: json['tvshowSeasonsDetailsId'] as int,
    posterPath: json['poster_path'] as String,
    seasonNumber: json['season_number'] as int,
  );
}

Map<String, dynamic> _$TvshowSeasonsDetailsToJson(
    TvshowSeasonsDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('air_date', instance.airDate?.toIso8601String());
  writeNotNull('episodes', instance.episodes);
  writeNotNull('name', instance.name);
  writeNotNull('overview', instance.overview);
  writeNotNull('tvshowSeasonsDetailsId', instance.tvshowSeasonsDetailsId);
  writeNotNull('poster_path', instance.posterPath);
  writeNotNull('season_number', instance.seasonNumber);
  return val;
}
