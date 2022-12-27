import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'poster_url_output.g.dart';

@JsonSerializable(createToJson: false)
class PosterUrlsOutput extends PosterUrLs {
  PosterUrlsOutput({
    String the92 = '',
    String the154 = '',
    String the185 = '',
    String the342 = '',
    String the500 = '',
    String the780 = '',
    String original = '',
  }) : super(
          the92: the92,
          the154: the154,
          the185: the185,
          the342: the342,
          the500: the500,
          the780: the780,
          original: original,
        );
  factory PosterUrlsOutput.fromJson(Map<String, dynamic> json) =>
      _$PosterUrlsOutputFromJson(json);
}
