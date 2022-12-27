// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      posterPath: json['poster_path'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble(),
      id: json['id'] as int,
      backdropPath: json['backdrop_path'] as String? ?? '',
      voteAverage: (json['voter_average'] as num?)?.toDouble(),
      overview: json['overview'] as String? ?? '',
      firstAirDate:
          Result._fromJsonFirstAirDate(json['first_air_date'] as String?),
      originCountry: (json['origin_country'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      originalLanguage: json['original_language'] as String? ?? '',
      voteCount: json['vote_count'] as int?,
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
    );

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'poster_path': instance.posterPath,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('popularity', instance.popularity);
  val['id'] = instance.id;
  val['backdrop_path'] = instance.backdropPath;
  writeNotNull('voter_average', instance.voteAverage);
  val['overview'] = instance.overview;
  writeNotNull('first_air_date', instance.firstAirDate?.toIso8601String());
  val['origin_country'] = instance.originCountry;
  val['genre_ids'] = instance.genreIds;
  val['original_language'] = instance.originalLanguage;
  writeNotNull('vote_count', instance.voteCount);
  val['name'] = instance.name;
  val['original_name'] = instance.originalName;
  return val;
}
