import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';

part 'file.g.dart';

@JsonSerializable(includeIfNull: false)
class TvshowsFile {
  TvshowsFile({required this.tvshows});

  factory TvshowsFile.fromRawJson(String str) =>
      _$TvshowsFileFromJson(json.decode(str));
  factory TvshowsFile.fromJson(Map<String, dynamic> json) =>
      _$TvshowsFileFromJson(json);

  final List<TvshowDetails> tvshows;

  Map<String, dynamic> toJson() => _$TvshowsFileToJson(this);
  String toRawJson() => json.encode(_$TvshowsFileToJson(this));
}
