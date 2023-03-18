import 'package:tv_randshow/core/trending/domain/models/media_type_enum.dart';

class TrendingResult {
  final String backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final MediaTypeEnum mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime? firstAirDate;
  final double voteAverage;
  final int voteCount;

  TrendingResult({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    this.genreIds = const [],
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
  });
}
