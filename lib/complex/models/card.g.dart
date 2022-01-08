// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardAdapter extends TypeAdapter<Card> {
  @override
  final int typeId = 0;

  @override
  Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Card(
      id: fields[0] as int,
      row: fields[1] as String,
      seqNum: fields[2] as int,
      text: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Card obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.row)
      ..writeByte(2)
      ..write(obj.seqNum)
      ..writeByte(3)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: json['id'] as int,
      row: json['row'] as String,
      seqNum: json['seq_num'] as int,
      text: json['text'] as String,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'row': instance.row,
      'seq_num': instance.seqNum,
      'text': instance.text,
    };
