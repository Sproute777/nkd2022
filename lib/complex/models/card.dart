import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'card.g.dart';

@HiveType(typeId: 0)
class Card extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int row;
  @HiveField(2)
  final int seqNum;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final bool isDeleting;
  

  Card(this.id, this.row, this.seqNum, this.text, this.isDeleting);

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        json['id'],
        json['row'],
        json['seq_num'],
        json['text'],
        false,
      );

  @override
  List<Object?> get props => [id, row, seqNum, text, isDeleting ];
}
