import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
enum ItemRow {
  @HiveField(0)
  @JsonValue('0')
  onHold,
  @HiveField(1)
  @JsonValue('1')
  inProgress,
  @HiveField(2)
  @JsonValue('2')
  needsReview,
  @HiveField(3)
  @JsonValue('3')
  approved,
}

@JsonSerializable()
@HiveType(typeId: 1)
class Item extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  @JsonKey(unknownEnumValue: ItemRow.onHold)
  final ItemRow row;
  @HiveField(2)
  @JsonKey(name: "seq_num")
  final int seqNum;
  @HiveField(3)
  final String text;
  Item({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,
  });
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    int? id,
    ItemRow? row,
    int? seqNum,
    String? text,
  }) {
    return Item(
      id: id ?? this.id,
      row: row ?? this.row,
      seqNum: seqNum ?? this.seqNum,
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [
        id,
        row,
        seqNum,
        text,
      ];
}
