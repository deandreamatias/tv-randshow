import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'streaming_detail_output.g.dart';

@JsonSerializable(createToJson: false)
class StreamingDetailOutput extends StreamingDetail {
  StreamingDetailOutput({
    int? rowId,
    required String streamingName,
    required String country,
    required String link,
    required int added,
    required int leaving,
    int? tvshowId,
  }) : super(
          tvshowId: tvshowId,
          rowId: rowId,
          streamingName: streamingName,
          added: added,
          country: country,
          leaving: leaving,
          link: link,
        );

  factory StreamingDetailOutput.fromJson(Map<String, dynamic> json) =>
      _$StreamingDetailOutputFromJson(json);
}
