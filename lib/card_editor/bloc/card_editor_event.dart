part of 'card_editor_bloc.dart';

abstract class CardEditorEvent extends Equatable {
  const CardEditorEvent();

  @override
  List<Object> get props => [];
}

class CardEditorRowChanged extends CardEditorEvent {
  const CardEditorRowChanged(this.row);
  final int row;
  @override
  List<Object> get props => [row];
}

class CardEditorTextChanged extends CardEditorEvent {
  const CardEditorTextChanged(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

class CardTextCompleted extends CardEditorEvent {}
