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
    required super.streamingName,
    required super.country,
    required super.link,
    required super.added,
    required super.leaving,
  });

  factory StreamingDetailOutput.fromJson(Map<String, dynamic> json) =>
      _$StreamingDetailOutputFromJson(json);
}
