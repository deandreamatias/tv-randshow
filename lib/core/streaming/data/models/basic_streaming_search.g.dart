// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_streaming_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicStreamingSearch _$BasicStreamingSearchFromJson(
        Map<String, dynamic> json) =>
    BasicStreamingSearch(
      tmdbId: json['tmdb_id'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$BasicStreamingSearchToJson(
        BasicStreamingSearch instance) =>
    <String, dynamic>{
      'tmdb_id': instance.tmdbId,
      'country': instance.country,
    };
