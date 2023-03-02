// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming_detail_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamingDetailOutput _$StreamingDetailOutputFromJson(
        Map<String, dynamic> json) =>
    StreamingDetailOutput(
      rowId: json['rowId'] as int?,
      tvshowId: json['tvshowId'] as int?,
      streamingName: json['streamingName'] as String,
      country: json['country'] as String,
      link: json['link'] as String? ?? '',
      added: json['added'] as int,
      leaving: json['leaving'] as int,
    );
