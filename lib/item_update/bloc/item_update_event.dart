part of 'item_update_bloc.dart';

abstract class ItemUpdateEvent extends Equatable {
  const ItemUpdateEvent();

  @override
  List<Object> get props => [];
}

class ItemUpdateItemChanged extends ItemUpdateEvent {
  const ItemUpdateItemChanged({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,
  });
  final int id;
  final String row;
  final int seqNum;
  final String text;
  @override
  List<Object> get props => [id, row, seqNum, text];
}

class ItemUpdateTextChanged extends ItemUpdateEvent {
  const ItemUpdateTextChanged(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

class ItemTextCompleted extends ItemUpdateEvent {}
