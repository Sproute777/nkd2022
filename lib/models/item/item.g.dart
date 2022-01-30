// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 1;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      id: fields[0] as int,
      row: fields[1] as ItemRow,
      seqNum: fields[2] as int,
      text: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
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
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemRowAdapter extends TypeAdapter<ItemRow> {
  @override
  final int typeId = 0;

  @override
  ItemRow read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemRow.onHold;
      case 1:
        return ItemRow.inProgress;
      case 2:
        return ItemRow.needsReview;
      case 3:
        return ItemRow.approved;
      default:
        return ItemRow.onHold;
    }
  }

  @override
  void write(BinaryWriter writer, ItemRow obj) {
    switch (obj) {
      case ItemRow.onHold:
        writer.writeByte(0);
        break;
      case ItemRow.inProgress:
        writer.writeByte(1);
        break;
      case ItemRow.needsReview:
        writer.writeByte(2);
        break;
      case ItemRow.approved:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemRowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int,
      row: $enumDecode(_$ItemRowEnumMap, json['row'],
          unknownValue: ItemRow.onHold),
      seqNum: json['seq_num'] as int,
      text: json['text'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'row': _$ItemRowEnumMap[instance.row],
      'seq_num': instance.seqNum,
      'text': instance.text,
    };

const _$ItemRowEnumMap = {
  ItemRow.onHold: '0',
  ItemRow.inProgress: '1',
  ItemRow.needsReview: '2',
  ItemRow.approved: '3',
};
