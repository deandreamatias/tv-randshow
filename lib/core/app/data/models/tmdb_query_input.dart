import 'package:json_annotation/json_annotation.dart';

part 'tmdb_query_input.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class TmdbQueryInput {
  String language;
  String? query;
  int? page;

  TmdbQueryInput({required this.language, this.query, this.page});

  Map<String, dynamic> toJson() => _$TmdbQueryInputToJson(this);
}
