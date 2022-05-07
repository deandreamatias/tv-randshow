// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvshow_seasons_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvshowSeasonsDetails _$TvshowSeasonsDetailsFromJson(
        Map<String, dynamic> json) =>
    TvshowSeasonsDetails(
      id: json['id'] as int,
      airDate:
          TvshowSeasonsDetails._fromJsonAirDate(json['air_date'] as String?),
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      tvshowSeasonsDetailsId: json['tvshowSeasonsDetailsId'] as int?,
      posterPath: json['poster_path'] as String? ?? '',
      seasonNumber: json['season_number'] as int,
    );

Map<String, dynamic> _$TvshowSeasonsDetailsToJson(
    TvshowSeasonsDetails instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('air_date', instance.airDate?.toIso8601String());
  val['episodes'] = instance.episodes;
  val['name'] = instance.name;
  val['overview'] = instance.overview;
  writeNotNull('tvshowSeasonsDetailsId', instance.tvshowSeasonsDetailsId);
  val['poster_path'] = instance.posterPath;
  val['season_number'] = instance.seasonNumber;
  return val;
}
