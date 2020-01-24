// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query _$QueryFromJson(Map<String, dynamic> json) {
  return Query(
    apiKey: json['api_key'] as String,
    language: json['language'] as String,
    query: json['query'] as String,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$QueryToJson(Query instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('api_key', instance.apiKey);
  writeNotNull('language', instance.language);
  writeNotNull('query', instance.query);
  writeNotNull('page', instance.page);
  return val;
}
