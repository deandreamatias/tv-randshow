import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'backdrop_urls_output.g.dart';

@JsonSerializable()
class BackdropUrlsOutput extends BackdropUrLs {
  BackdropUrlsOutput({
    String the300 = '',
    String the780 = '',
    String the1280 = '',
    String original = '',
  }) : super(
          the300: the300,
          the780: the780,
          the1280: the1280,
          original: original,
        );

  factory BackdropUrlsOutput.fromJson(Map<String, dynamic> json) =>
      _$BackdropUrlsOutputFromJson(json);
  Map<String, dynamic> toJson() => _$BackdropUrlsOutputToJson(this);
}
