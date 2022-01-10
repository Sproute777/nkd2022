import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../complex/complex.dart';
import '../item_update.dart';

part 'item_update_event.dart';
part 'item_update_state.dart';

class ItemUpdateBloc extends Bloc<ItemUpdateEvent, ItemUpdateState> {
  final ComplexListBloc _complexListBloc;
  ItemUpdateBloc({required ComplexListBloc complexListBloc})
      : _complexListBloc = complexListBloc,
        super(const ItemUpdateState.empty()) {
    on<ItemUpdateItemChanged>((event, emit) {
      final text = ItemText.dirty(event.text);
      emit(state.copyWith(
        id: event.id,
        row: event.row,
        seqNum: event.seqNum,
        text: text,
      ));
    });

    on<ItemUpdateTextChanged>((event, emit) {
      final text = ItemText.dirty(event.text);
      emit(state.copyWith(
          row: state.row, text: text, status: Formz.validate([state.text])));
    });

    on<ItemTextCompleted>((event, emit) async {
      if (state.status.isValidated) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        _complexListBloc.add(UpdateComplexItem(
            id: state.id,
            row: state.row,
            seqNum: state.seqNum,
            text: state.text.value));
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
