// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
      apiKey: json['api_key'] as String,
      language: json['language'] as String,
      query: json['query'] as String?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$QueryToJson(Query instance) {
  final val = <String, dynamic>{
    'api_key': instance.apiKey,
    'language': instance.language,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('query', instance.query);
  writeNotNull('page', instance.page);
  return val;
}
