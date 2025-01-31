// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_sentence_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CorrectionSentenceDtoAdapter extends TypeAdapter<CorrectionSentenceDto> {
  @override
  final int typeId = 2;

  @override
  CorrectionSentenceDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CorrectionSentenceDto(
      originSentence: fields[0] as String,
      correctSentence: fields[1] as String,
      correctionReason: fields[2] as String?,
      nativeInterpretation: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CorrectionSentenceDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.originSentence)
      ..writeByte(1)
      ..write(obj.correctSentence)
      ..writeByte(2)
      ..write(obj.correctionReason)
      ..writeByte(3)
      ..write(obj.nativeInterpretation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectionSentenceDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
