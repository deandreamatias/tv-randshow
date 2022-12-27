// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamingOutput _$StreamingOutputFromJson(Map<String, dynamic> json) =>
    StreamingOutput(
      imdbId: json['imdbId'] as String? ?? '',
      tmdbId: json['tmdbId'] as String? ?? '',
      imdbRating: json['imdbRating'] as int,
      imdbVoteCount: json['imdbVoteCount'] as int,
      tmdbRating: json['tmdbRating'] as int,
      backdropPath: json['backdropPath'] as String? ?? '',
      backdropUrLsOutput: json['backdropURLs'] == null
          ? null
          : BackdropUrlsOutput.fromJson(
              json['backdropURLs'] as Map<String, dynamic>),
      originalTitle: json['originalTitle'] as String? ?? '',
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      year: json['year'] as int,
      firstAirYear: json['firstAirYear'] as int,
      lastAirYear: json['lastAirYear'] as int,
      episodeRuntimes: (json['episodeRuntimes'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      cast:
          (json['cast'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      significants: (json['significants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      video: json['video'] as String? ?? '',
      posterPath: json['posterPath'] as String? ?? '',
      posterUrLsOutput: json['posterURLs'] == null
          ? null
          : PosterUrlsOutput.fromJson(
              json['posterURLs'] as Map<String, dynamic>),
      seasons: json['seasons'] as int,
      episodes: json['episodes'] as int,
      age: json['age'] as int,
      status: json['status'] as int,
      tagline: json['tagline'] as String? ?? '',
      streamingInfoOutput: json['streamingInfo'] == null
          ? const []
          : StreamingOutput._streamingsFromJson(
              json['streamingInfo'] as Map<String, dynamic>),
      originalLanguage: json['originalLanguage'] as String? ?? '',
    );
