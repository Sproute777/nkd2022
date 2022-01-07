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
  ComplexListBloc({required ComplexRepository repository,  Connectivity? connectivity})
      : _repository = repository,
        _connectivity = connectivity ?? Connectivity(),
        super(const ComplexListState()) {
    on<LoadComplexList>(_onLoadList);
    on<CreateComplexItem>(_onCreateItem);
    // on<UpdateCardEvent>((event, emit) {});
    // on<DeleteCardEvent>((event, emit) {});
    on<ConnectivityComplexChanged>(_onConnectivityChanged);
     _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result){
           add(ConnectivityComplexChanged(result));
        });
  }

  Future<void> _onLoadList(LoadComplexList event, Emitter<ComplexListState> emit) async {
    final result = await _connectivity.checkConnectivity();
    if ( result == ConnectivityResult.wifi || 
         result == ConnectivityResult.mobile )  {
    try {
      final _cards = await _repository.getCards();  
      if (_cards.isNotEmpty) {
        _repository.addHiveCards(_cards);
         emit(state.copyWith(status: ComplexStatus.success, cards:_cards));
        }
       emit(state.copyWith(status: ComplexStatus.success, cards: <Card>[])); 
    
    } on Exception catch (_) {
      emit(state.copyWith(status: ComplexStatus.failure,)); 

    }} else {
      final _cards = await _repository.fetchHiveCards();
      if(_cards != null) {
         emit(state.copyWith(status: ComplexStatus.success, cards: _cards)); 
     
      }  
  }
  }

  Future<void> _onCreateItem(CreateComplexItem event, Emitter<ComplexListState> emit)async {
     if(state.connectivity == ConnectivityResult.none) return;
     emit(state.copyWith(status: ComplexStatus.loading));
     int result = await _repository.createCard(event.row, event.text);
    //  if ( result == 200) {
    //    emit(state.copyWith( 
    //      status: ComplexStatus.success,
    //      cards:  List.of(state.cards)..add(event.Card) 
    //    ));
    //  }

  }

  Future<void> _onConnectivityChanged(ConnectivityComplexChanged event ,Emitter<ComplexListState> emit)async {
    emit(state.copyWith(connectivity: event.result));
  }
 

 @override
  Future<void> close() async{
  _connectivitySubscription.cancel();
   return super.close();
 }
}
