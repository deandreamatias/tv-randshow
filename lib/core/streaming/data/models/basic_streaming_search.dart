import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

part 'basic_streaming_search.g.dart';

@JsonSerializable()
class BasicStreamingSearch extends StreamingSearch {
  @JsonKey(name: 'tmdb_id')
  final String tmdbIdOutput;

  BasicStreamingSearch({
    required this.tmdbIdOutput,
    required super.country,
  }) : super(
          tmdbId: tmdbIdOutput,
        );

  factory BasicStreamingSearch.fromJson(Map<String, dynamic> json) =>
      _$BasicStreamingSearchFromJson(json);

  Map<String, dynamic> toJson() => _$BasicStreamingSearchToJson(this);
}
