import 'package:json_annotation/json_annotation.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

part 'streaming_detail_input.g.dart';

@JsonSerializable(createFactory: false)
class StreamingDetailInput extends StreamingDetail {
  final int tvshowId;
  @JsonKey(ignore: true)
  final String? id;
  StreamingDetailInput({
    required String streamingName,
    required String country,
    required String link,
    required int added,
    required int leaving,
    required this.tvshowId,
    this.id,
  }) : super(
          streamingName: streamingName,
          added: added,
          country: country,
          leaving: leaving,
          link: link,
        );

  Map<String, dynamic> toJson() => _$StreamingDetailInputToJson(this);
}
