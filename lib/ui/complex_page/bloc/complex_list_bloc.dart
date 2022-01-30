import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/repository/complex_repository.dart';
import 'package:bloc_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity/connectivity.dart';

import '../complex_page.dart';

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
    on<UpdateComplexItem>(_onUpdateItem);
    on<DeleteComplexItem>(_onDeleteItem);
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
        final _items = await _repository.getItems();
        if (_items.isNotEmpty) {
          _repository.clearHiveBox();
          _repository.addAllHive(_items);
          return emit(
              state.copyWith(status: ComplexStatus.success, items: _items));
        }
        _repository.clearHiveBox();
        return emit(
            state.copyWith(status: ComplexStatus.success, items: <Item>[]));
      } on Exception catch (_) {
        emit(state.copyWith(
          status: ComplexStatus.failure,
        ));
      }
    } else {
      final _items = await _repository.fetchAllHive();
      if (_items != null) {
        emit(state.copyWith(status: ComplexStatus.success, items: _items));
      }
    }
  }

  Future<void> _onCreateItem(
      CreateComplexItem event, Emitter<ComplexListState> emit) async {
    if (!state.hasConnectivity) return;
    emit(state.copyWith(status: ComplexStatus.loading));
    var json = await _repository.createItem(event.row, event.text);
    if (json != null) {
      final item = Item.fromJson(json);
      await _repository.addOneHive(item);
      return emit(state.copyWith(
          status: ComplexStatus.success,
          items: List.of(state.items)..add(item)));
    }
    return emit(state.copyWith(status: ComplexStatus.success));
  }

  Future<void> _onUpdateItem(
      UpdateComplexItem event, Emitter<ComplexListState> emit) async {
    if (!state.hasConnectivity) return;
    emit(state.copyWith(status: ComplexStatus.loading));
    var json = await _repository.updateItem(
        id: event.id, row: event.row, seqNum: event.seqNum, text: event.text);
    if (json != null) {
      final item = Item.fromJson(json);
      final items = List.of(state.items)
        ..removeWhere((element) => element.id == item.id)
        ..add(item);
      _repository.addOneHive(item);
      return emit(state.copyWith(status: ComplexStatus.success, items: items));
    }
    return emit(state.copyWith(status: ComplexStatus.success));
  }

  Future<void> _onDeleteItem(
      DeleteComplexItem event, Emitter<ComplexListState> emit) async {
    if (!state.hasConnectivity) return;
    emit(state.copyWith(status: ComplexStatus.loading));
    var result = await _repository.deleteItem(event.id);
    if (result == 204) {
      _repository.deleteItem(event.id);
      final items = List.of(state.items)
        ..removeWhere((element) => element.id == event.id);
      return emit(state.copyWith(status: ComplexStatus.success, items: items));
    }
    return emit(state.copyWith(status: ComplexStatus.success));
  }

  Future<void> _onConnectivityChanged(
      ConnectivityComplexChanged event, Emitter<ComplexListState> emit) async {
    emit(state.copyWith(connectivity: event.result));
  }

  @override
  Future<void> close() async {
    _connectivitySubscription.cancel();
    _repository.close();
    return super.close();
  }
}
