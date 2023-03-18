import 'package:json_annotation/json_annotation.dart';

class DateTimeTransformer implements JsonConverter<DateTime?, String?> {
  const DateTimeTransformer();

  @override
  DateTime? fromJson(String? json) =>
      json == null || json.isEmpty ? null : DateTime.parse(json);

  @override
  String? toJson(DateTime? object) => object?.toIso8601String();
}
