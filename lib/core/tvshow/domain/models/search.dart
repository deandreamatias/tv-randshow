import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/tvshow/domain/models/result.dart';

part 'search.g.dart';

@JsonSerializable(includeIfNull: false)
class Search {
  Search({
    this.page,
    this.results = const [],
    this.totalResults = 0,
    this.totalPages = 0,
  });

  factory Search.fromRawJson(String str) => _$SearchFromJson(json.decode(str));
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  int? page;
  List<Result> results;
  @JsonKey(name: 'total_results')
  int totalResults;
  @JsonKey(name: 'total_pages')
  int totalPages;

  Map<String, dynamic> toJson() => _$SearchToJson(this);
  String toRawJson() => json.encode(_$SearchToJson(this));
}
