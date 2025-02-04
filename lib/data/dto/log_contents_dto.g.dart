// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_contents_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogContentsDtoAdapter extends TypeAdapter<LogContentsDto> {
  @override
  final int typeId = 1;

  @override
  LogContentsDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogContentsDto(
      title: fields[0] as String,
      contents: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogContentsDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.contents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogContentsDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
