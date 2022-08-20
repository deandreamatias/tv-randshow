// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming_detail_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreamingDetailHiveAdapter extends TypeAdapter<StreamingDetailHive> {
  @override
  final int typeId = 2;

  @override
  StreamingDetailHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreamingDetailHive(
      streamingName: fields[0] as String,
      link: fields[2] as String,
      added: fields[3] as int,
      leaving: fields[4] as int,
      country: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StreamingDetailHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.streamingName)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.added)
      ..writeByte(4)
      ..write(obj.leaving);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamingDetailHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
