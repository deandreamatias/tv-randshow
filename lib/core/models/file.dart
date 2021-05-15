import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'tvshow_details.dart';

part 'file.g.dart';

@JsonSerializable(includeIfNull: false)
class TvshowsFile {
  TvshowsFile({this.tvshows});

  factory TvshowsFile.fromRawJson(String str) =>
      _$FileFromJson(json.decode(str));
  factory TvshowsFile.fromJson(Map<String, dynamic> json) =>
      _$FileFromJson(json);

  final List<TvshowDetails> tvshows;

  Map<String, dynamic> toJson() => _$TvShowsFileToJson(this);
  String toRawJson() => json.encode(_$TvShowsFileToJson(this));
}
