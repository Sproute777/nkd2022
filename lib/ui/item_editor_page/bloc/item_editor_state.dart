part of 'item_editor_bloc.dart';

class ItemEditorState extends Equatable {
  final String row;
  final ItemText text;
  final FormzStatus status;
  const ItemEditorState._({
    this.status = FormzStatus.pure,
    this.row = "0",
    this.text = const ItemText.pure(),
  });
  const ItemEditorState.empty() : this._();

  ItemEditorState copyWith({
    String? row,
    ItemText? text,
    FormzStatus? status,
  }) {
    return ItemEditorState._(
      row: row ?? this.row,
      text: text ?? this.text,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [text, row, status];
}
