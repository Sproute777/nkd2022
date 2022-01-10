import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Item extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String row;
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

  @override
  List<Object> get props => [
        id,
        row,
        seqNum,
        text,
      ];
}