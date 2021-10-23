// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvshowsFile _$TvshowsFileFromJson(Map<String, dynamic> json) => TvshowsFile(
      tvshows: (json['tvshows'] as List<dynamic>)
          .map((e) => TvshowDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvshowsFileToJson(TvshowsFile instance) =>
    <String, dynamic>{
      'tvshows': instance.tvshows,
    };
