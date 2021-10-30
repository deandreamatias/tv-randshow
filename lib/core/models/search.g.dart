// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalResults: json['total_results'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
    );

Map<String, dynamic> _$SearchToJson(Search instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  val['results'] = instance.results;
  val['total_results'] = instance.totalResults;
  val['total_pages'] = instance.totalPages;
  return val;
}
