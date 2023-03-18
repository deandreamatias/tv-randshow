import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/app/data/transformers/date_time_transformer.dart';
import 'package:tv_randshow/core/trending/domain/models/media_type_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';

part 'trending_result_data_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
@DateTimeTransformer()
class TrendingResultDataModel {
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

  const TrendingResultDataModel({
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

  factory TrendingResultDataModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingResultDataModelFromJson(json);

  TrendingResult toDomain() {
    return TrendingResult(
      backdropPath: backdropPath,
      id: id,
      name: name,
      originalLanguage: originalLanguage,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType,
      popularity: popularity,
      firstAirDate: firstAirDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
