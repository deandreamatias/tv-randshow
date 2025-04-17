import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/app/domain/models/pagination_model.dart';

part 'pagination_data_model.g.dart';

@JsonSerializable(
  createToJson: false,
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class PaginationDataModel<T> {
  final int? page;
  final int totalResults;
  final int totalPages;
  final List<T> results;

  const PaginationDataModel({
    this.page,
    this.results = const [],
    this.totalResults = 0,
    this.totalPages = 0,
  });

  factory PaginationDataModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationDataModelFromJson<T>(json, fromJsonT);

  PaginationModel<T> toDomain() {
    return PaginationModel<T>(
      page: page,
      results: results,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
