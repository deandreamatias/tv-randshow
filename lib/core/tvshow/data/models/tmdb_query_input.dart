import 'package:json_annotation/json_annotation.dart';

part 'tmdb_query_input.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class TmdbQueryInput {
  TmdbQueryInput({
    required this.language,
    this.query,
    this.page,
  });

  String language;
  String? query;
  int? page;

  Map<String, dynamic> toJson() => _$TmdbQueryInputToJson(this);
}
