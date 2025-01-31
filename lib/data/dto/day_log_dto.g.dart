// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_log_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayLogDtoAdapter extends TypeAdapter<DayLogDto> {
  @override
  final int typeId = 0;

  @override
  DayLogDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayLogDto(
      date: fields[0] as String,
      emotion: fields[1] as String,
      native: fields[2] as LogContentsDto?,
      foreign: fields[3] as LogContentsDto?,
      correctionResult: fields[4] as String?,
      correctionSentence: (fields[5] as List?)?.cast<CorrectionSentenceDto>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayLogDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.emotion)
      ..writeByte(2)
      ..write(obj.native)
      ..writeByte(3)
      ..write(obj.foreign)
      ..writeByte(4)
      ..write(obj.correctionResult)
      ..writeByte(5)
      ..write(obj.correctionSentence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayLogDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
