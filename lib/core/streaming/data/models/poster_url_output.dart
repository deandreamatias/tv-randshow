import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'poster_url_output.g.dart';

@JsonSerializable(createToJson: false)
class PosterUrlsOutput extends PosterUrLs {
  PosterUrlsOutput({
    super.the92,
    super.the154,
    super.the185,
    super.the342,
    super.the500,
    super.the780,
    super.original,
  });
  factory PosterUrlsOutput.fromJson(Map<String, dynamic> json) =>
      _$PosterUrlsOutputFromJson(json);
}
