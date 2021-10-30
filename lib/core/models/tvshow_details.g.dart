// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvshow_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvshowDetailsAdapter extends TypeAdapter<TvshowDetails> {
  @override
  final int typeId = 1;

  @override
  TvshowDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvshowDetails(
      rowId: fields[0] as int?,
      episodeRunTime: (fields[1] as List).cast<int>(),
      id: fields[2] as int,
      inProduction: fields[3] as dynamic,
      name: fields[4] as String,
      numberOfEpisodes: fields[5] as int,
      numberOfSeasons: fields[6] as int,
      overview: fields[7] as String,
      posterPath: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TvshowDetails obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.rowId)
      ..writeByte(1)
      ..write(obj.episodeRunTime)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.inProduction)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.numberOfEpisodes)
      ..writeByte(6)
      ..write(obj.numberOfSeasons)
      ..writeByte(7)
      ..write(obj.overview)
      ..writeByte(8)
      ..write(obj.posterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvshowDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvshowDetails _$TvshowDetailsFromJson(Map<String, dynamic> json) =>
    TvshowDetails(
      rowId: json['rowId'] as int?,
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      id: json['id'] as int,
      inProduction: json['in_production'],
      name: json['name'] as String,
      numberOfEpisodes: json['number_of_episodes'] as int,
      numberOfSeasons: json['number_of_seasons'] as int,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TvshowDetailsToJson(TvshowDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rowId', instance.rowId);
  val['episode_run_time'] = instance.episodeRunTime;
  val['id'] = instance.id;
  writeNotNull('in_production', instance.inProduction);
  val['name'] = instance.name;
  val['number_of_episodes'] = instance.numberOfEpisodes;
  val['number_of_seasons'] = instance.numberOfSeasons;
  val['overview'] = instance.overview;
  val['poster_path'] = instance.posterPath;
  val['seasons'] = instance.seasons;
  return val;
}
