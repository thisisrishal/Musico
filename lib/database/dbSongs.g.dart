// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbSongs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class dbSongsAdapter extends TypeAdapter<dbSongs> {
  @override
  final int typeId = 0;

  @override
  dbSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return dbSongs(
      title: fields[0] as String?,
      artist: fields[1] as String?,
      uri: fields[2] as String?,
      duration: fields[3] as int?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, dbSongs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is dbSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
