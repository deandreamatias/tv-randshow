import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';

@JsonSerializable(includeIfNull: false)
class Query {
  Query({
    this.apiKey,
    this.language,
    this.query,
    this.page,
  });

  factory Query.fromRawJson(String str) => _$QueryFromJson(json.decode(str));
  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  @JsonKey(name: 'api_key')
  String apiKey;
  String language;
  String query;
  int page;

  Map<String, dynamic> toJson() => _$QueryToJson(this);
  String toRawJson() => json.encode(_$QueryToJson(this));
}
