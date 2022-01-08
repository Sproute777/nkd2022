import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'card.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Card extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String row;
  @HiveField(2)
  @JsonKey(name: "seq_num")
  final int seqNum;
  @HiveField(3)
  final String text;
  Card({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,
  });
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);

  @override
  List<Object> get props => [
        id,
        row,
        seqNum,
        text,
      ];
}
