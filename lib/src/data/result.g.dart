// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    posterPath: json['poster_path'] as String,
    popularity: (json['popularity'] as num)?.toDouble(),
    id: json['id'] as int,
    backdropPath: json['backdrop_path'] as String,
    voteAverage: (json['voter_average'] as num)?.toDouble(),
    overview: json['overview'] as String,
    firstAirDate: json['first_ari_date'] == null
        ? null
        : DateTime.parse(json['first_ari_date'] as String),
    originCountry:
        (json['origin_country'] as List)?.map((e) => e as String)?.toList(),
    genreIds: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    originalLanguage: json['original_language'] as String,
    voteCount: json['vote_count'] as int,
    name: json['name'] as String,
    originalName: json['original_name'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('poster_path', instance.posterPath);
  writeNotNull('popularity', instance.popularity);
  writeNotNull('id', instance.id);
  writeNotNull('backdrop_path', instance.backdropPath);
  writeNotNull('voter_average', instance.voteAverage);
  writeNotNull('overview', instance.overview);
  writeNotNull('first_ari_date', instance.firstAirDate?.toIso8601String());
  writeNotNull('origin_country', instance.originCountry);
  writeNotNull('genre_ids', instance.genreIds);
  writeNotNull('original_language', instance.originalLanguage);
  writeNotNull('vote_count', instance.voteCount);
  writeNotNull('name', instance.name);
  writeNotNull('original_name', instance.originalName);
  return val;
}
