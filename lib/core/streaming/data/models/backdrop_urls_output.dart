import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'backdrop_urls_output.g.dart';

@JsonSerializable()
class BackdropUrlsOutput extends BackdropUrLs {
  BackdropUrlsOutput({
    super.the300,
    super.the780,
    super.the1280,
    super.original,
  });

  factory BackdropUrlsOutput.fromJson(Map<String, dynamic> json) =>
      _$BackdropUrlsOutputFromJson(json);
  Map<String, dynamic> toJson() => _$BackdropUrlsOutputToJson(this);
}
