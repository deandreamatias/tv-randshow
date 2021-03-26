import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'tvshow_details.dart';

part 'file.g.dart';

@JsonSerializable(includeIfNull: false)
class File {
  File({this.tvshows});

  factory File.fromRawJson(String str) => _$FileFromJson(json.decode(str));
  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  final List<TvshowDetails> tvshows;

  Map<String, dynamic> toJson() => _$FileToJson(this);
  String toRawJson() => json.encode(_$FileToJson(this));
}
