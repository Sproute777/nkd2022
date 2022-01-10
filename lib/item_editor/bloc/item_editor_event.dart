part of 'item_editor_bloc.dart';

abstract class ItemEditorEvent extends Equatable {
  const ItemEditorEvent();

  @override
  List<Object> get props => [];
}

class ItemEditorRowChanged extends ItemEditorEvent {
  const ItemEditorRowChanged(this.row);
  final String row;
  @override
  List<Object> get props => [row];
}

class ItemEditorTextChanged extends ItemEditorEvent {
  const ItemEditorTextChanged(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

class ItemTextCompleted extends ItemEditorEvent {}
