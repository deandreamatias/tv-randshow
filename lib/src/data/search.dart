import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/src/data/result.dart';

part 'search.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class Search {
  Search({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory Search.fromRawJson(String str) => _$SearchFromJson(json.decode(str));
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  
  int page;
  List<Result> results;
  @JsonKey(name: 'total_results')
  int totalResults;
  @JsonKey(name: 'total_pages')
  int totalPages;

  Map<String, dynamic> toJson() => _$SearchToJson(this);
  String toRawJson() => json.encode(_$SearchToJson(this));
}
