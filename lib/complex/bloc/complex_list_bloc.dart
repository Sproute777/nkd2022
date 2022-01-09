import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity/connectivity.dart';

import '../complex.dart';

part 'complex_list_event.dart';
part 'complex_list_state.dart';

class ComplexListBloc extends Bloc<ComplexListEvent, ComplexListState> {
  final ComplexRepository _repository;
  final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ComplexListBloc(
      {required ComplexRepository repository, Connectivity? connectivity})
      : _repository = repository,
        _connectivity = connectivity ?? Connectivity(),
        super(const ComplexListState()) {
    on<LoadComplexList>(_onLoadList);
    on<CreateComplexItem>(_onCreateItem);
    // on<UpdateCardEvent>((event, emit) {});
    // on<DeleteCardEvent>((event, emit) {});
    on<ConnectivityComplexChanged>(_onConnectivityChanged);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      add(ConnectivityComplexChanged(result));
    });
  }

  Future<void> _onLoadList(
      LoadComplexList event, Emitter<ComplexListState> emit) async {
    if (state.hasConnectivity) {
      try {
        emit(state.copyWith(status: ComplexStatus.loading));
        final _cards = await _repository.getCards();
        if (_cards.isNotEmpty) {
          _repository.clearHiveCards();
          _repository.addHiveCards(_cards);
          return emit(
              state.copyWith(status: ComplexStatus.success, cards: _cards));
        }
        _repository.clearHiveCards();
        return emit(
            state.copyWith(status: ComplexStatus.success, cards: <Card>[]));
      } on Exception catch (_) {
        emit(state.copyWith(
          status: ComplexStatus.failure,
        ));
      }
    } else {
      final _cards = await _repository.fetchHiveCards();
      if (_cards != null) {
        emit(state.copyWith(status: ComplexStatus.success, cards: _cards));
      }
    }
  }

  Future<void> _onCreateItem(
      CreateComplexItem event, Emitter<ComplexListState> emit) async {
    if (!state.hasConnectivity) return;
    emit(state.copyWith(status: ComplexStatus.loading));
    var response = await _repository.createCard(event.row, event.text);
    if (response.result == 201) {
      final card = Card.fromJson(response.data);
      emit(state.copyWith(
          status: ComplexStatus.success,
          cards: List.of(state.cards)..add(card)));
    }
  }

  Future<void> _onConnectivityChanged(
      ConnectivityComplexChanged event, Emitter<ComplexListState> emit) async {
    emit(state.copyWith(connectivity: event.result));
  }

  @override
  Future<void> close() async {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
