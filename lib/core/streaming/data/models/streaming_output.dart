import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

import 'backdrop_urls_output.dart';
import 'poster_url_output.dart';
import 'streaming_detail_output.dart';

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
    String imdbId = '',
    String tmdbId = '',
    required int imdbRating,
    required int imdbVoteCount,
    required int tmdbRating,
    String backdropPath = '',
    this.backdropUrLsOutput,
    String originalTitle = '',
    List<int> genres = const [],
    List<String> countries = const [],
    required int year,
    required int firstAirYear,
    required int lastAirYear,
    List<int> episodeRuntimes = const [],
    List<String> cast = const [],
    List<String> significants = const [],
    String title = '',
    String overview = '',
    String video = '',
    String posterPath = '',
    this.posterUrLsOutput,
    required int seasons,
    required int episodes,
    required int age,
    required int status,
    String tagline = '',
    this.streamingInfoOutput = const [],
    String originalLanguage = '',
  }) : super(
          age: age,
          backdropUrLs: backdropUrLsOutput,
          episodes: episodes,
          firstAirYear: firstAirYear,
          imdbRating: imdbRating,
          imdbVoteCount: imdbVoteCount,
          lastAirYear: lastAirYear,
          posterUrLs: posterUrLsOutput,
          seasons: seasons,
          status: status,
          streamings: streamingInfoOutput,
          tmdbRating: tmdbRating,
          year: year,
          backdropPath: backdropPath,
          cast: cast,
          countries: countries,
          episodeRuntimes: episodeRuntimes,
          genres: genres,
          imdbId: imdbId,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          posterPath: posterPath,
          significants: significants,
          tagline: tagline,
          title: title,
          tmdbId: tmdbId,
          video: video,
        );

  factory StreamingOutput.fromJson(Map<String, dynamic> json) =>
      _$StreamingOutputFromJson(json);

  /// Simplify json streaming
  static List<StreamingDetailOutput> _streamingsFromJson(
      Map<String, dynamic> json) {
    if (json.entries.isEmpty) {
      return [];
    }
    return json.entries.map((streaming) {
      final countries = streaming.value as Map<String, dynamic>;

      /// TODO: Add all countries to list
      final Map<String, dynamic> streamingDetail =
          countries.entries.map((countries) => countries.value).first;

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
