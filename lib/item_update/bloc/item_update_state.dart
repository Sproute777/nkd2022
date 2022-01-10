part of 'item_update_bloc.dart';

class ItemUpdateState extends Equatable {
  final int id;
  final String row;
  final int seqNum;
  final ItemText text;
  final FormzStatus status;
  const ItemUpdateState._({
    this.id = 0,
    this.row = '0',
    this.seqNum = 0,
    this.status = FormzStatus.pure,
    this.text = const ItemText.pure(),
  });
  const ItemUpdateState.empty() : this._();

  ItemUpdateState copyWith({
    int? id,
    String? row,
    int? seqNum,
    ItemText? text,
    FormzStatus? status,
  }) {
    return ItemUpdateState._(
      id: id ?? this.id,
      row: row ?? this.row,
      seqNum: seqNum ?? this.seqNum,
      text: text ?? this.text,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [id, seqNum, text, row, status];
}
