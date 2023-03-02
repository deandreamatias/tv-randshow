import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'streaming_detail_input.g.dart';

@JsonSerializable(createFactory: false)
class StreamingDetailInput extends StreamingDetail {
  final int tvshowId;
  StreamingDetailInput({
    required super.streamingName,
    required super.country,
    required super.link,
    required super.added,
    required super.leaving,
    required this.tvshowId,
  });

  Map<String, dynamic> toJson() => _$StreamingDetailInputToJson(this);
}
