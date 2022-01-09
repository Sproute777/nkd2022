part of 'card_editor_bloc.dart';

class CardEditorState extends Equatable {
  final int row;
  final CardText text;
  final FormzStatus status;
  const CardEditorState._({
    this.status = FormzStatus.pure,
    this.row = 0,
    this.text = const CardText.pure(),
  });
  const CardEditorState.empty() : this._();

  CardEditorState copyWith({
    int? row,
    CardText? text,
    FormzStatus? status,
  }) {
    return CardEditorState._(
      row: row ?? this.row,
      text: text ?? this.text,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [text, row, status];
}
