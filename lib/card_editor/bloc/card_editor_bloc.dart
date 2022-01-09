import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../complex/complex.dart';
import '../card_editor.dart';

part 'card_editor_event.dart';
part 'card_editor_state.dart';

class CardEditorBloc extends Bloc<CardEditorEvent, CardEditorState> {
  final ComplexListBloc _complexListBloc;
  CardEditorBloc({required ComplexListBloc complexListBloc})
      : _complexListBloc = complexListBloc,
        super(const CardEditorState.empty()) {
    on<CardEditorRowChanged>((event, emit) {
      emit(state.copyWith(row: event.row));
    });

    on<CardEditorTextChanged>((event, emit) {
      final text = CardText.dirty(event.text);
      emit(state.copyWith(
          row: state.row, text: text, status: Formz.validate([state.text])));
    });

    on<CardTextCompleted>((event, emit) async {
      if (state.status.isValidated) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        _complexListBloc
            .add(CreateComplexItem(row: state.row, text: state.text.value));
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
