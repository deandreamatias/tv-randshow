import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'streaming_detail_output.g.dart';

@JsonSerializable(includeIfNull: false, createToJson: false)
class StreamingDetailOutput extends StreamingDetail {
  final int? rowId;
  final int? tvshowId;
  StreamingDetailOutput({
    this.rowId,
    this.tvshowId,
    required String streamingName,
    required String country,
    required String link,
    required int added,
    required int leaving,
  }) : super(
          streamingName: streamingName,
          added: added,
          country: country,
          leaving: leaving,
          link: link,
        );

  factory StreamingDetailOutput.fromJson(Map<String, dynamic> json) =>
      _$StreamingDetailOutputFromJson(json);
}
