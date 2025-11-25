import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/data/models/backdrop_urls_output.dart';
import 'package:tv_randshow/core/streaming/data/models/poster_urls_output.dart';
import 'package:tv_randshow/core/streaming/data/models/streaming_detail_output.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'streaming_output.g.dart';

@JsonSerializable(createToJson: false)
class StreamingOutput extends Streaming {
  @JsonKey(name: 'streamingInfo', fromJson: _streamingsFromJson)
  final List<StreamingDetailOutput> streamingInfoOutput;
  @JsonKey(name: 'backdropURLs')
  final BackdropUrlsOutput? backdropUrLsOutput;
  @JsonKey(name: 'posterURLs')
  final PosterUrlsOutput? posterUrLsOutput;

  StreamingOutput({
    super.imdbId,
    super.tmdbId,
    required super.imdbRating,
    required super.imdbVoteCount,
    required super.tmdbRating,
    super.backdropPath,
    this.backdropUrLsOutput,
    super.originalTitle,
    super.genres,
    super.countries,
    required super.year,
    required super.firstAirYear,
    required super.lastAirYear,
    super.episodeRuntimes,
    super.cast,
    super.significants,
    super.title,
    super.overview,
    super.video,
    super.posterPath,
    this.posterUrLsOutput,
    required super.seasons,
    required super.episodes,
    required super.age,
    required super.status,
    super.tagline,
    this.streamingInfoOutput = const [],
    super.originalLanguage,
  }) : super(
         backdropUrLs: backdropUrLsOutput,
         posterUrLs: posterUrLsOutput,
         streamings: streamingInfoOutput,
       );

  factory StreamingOutput.fromJson(Map<String, dynamic> json) =>
      _$StreamingOutputFromJson(json);

  /// Simplify json streaming.
  static List<StreamingDetailOutput> _streamingsFromJson(
    Map<String, dynamic> json,
  ) {
    if (json.entries.isEmpty) {
      return [];
    }

    return json.entries.map((streaming) {
      final countries = streaming.value as Map<String, dynamic>;

      /// TODO: Add all countries to list.
      final Map<String, dynamic> streamingDetail = countries.entries
          .map((countries) => countries.value)
          .first;

      return StreamingDetailOutput(
        country: countries.entries.first.key,
        link: streamingDetail['link'],
        added: streamingDetail['added'],
        leaving: streamingDetail['leaving'],
        streamingName: streaming.key,
      );
    }).toList();
  }
}
