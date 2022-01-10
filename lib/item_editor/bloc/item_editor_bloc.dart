import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../complex/complex.dart';
import '../item_editor.dart';

part 'item_editor_event.dart';
part 'item_editor_state.dart';

class ItemEditorBloc extends Bloc<ItemEditorEvent, ItemEditorState> {
  final ComplexListBloc _complexListBloc;
  ItemEditorBloc({required ComplexListBloc complexListBloc})
      : _complexListBloc = complexListBloc,
        super(const ItemEditorState.empty()) {
    on<ItemEditorRowChanged>((event, emit) {
      emit(state.copyWith(row: event.row));
    });

    on<ItemEditorTextChanged>((event, emit) {
      final text = ItemText.dirty(event.text);
      emit(state.copyWith(
          row: state.row, text: text, status: Formz.validate([state.text])));
    });

    on<ItemTextCompleted>((event, emit) async {
      if (state.status.isValidated) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        _complexListBloc
            .add(CreateComplexItem(row: state.row, text: state.text.value));
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
