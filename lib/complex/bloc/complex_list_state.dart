part of 'complex_list_bloc.dart';

enum ComplexStatus {  loading, success, failure }

class ComplexListState extends Equatable {
  const ComplexListState({
    this.status = ComplexStatus.loading,
    this.cards = const <Card>[],
    this.connectivity = ConnectivityResult.mobile,
  });

  final ComplexStatus status;
  final List<Card> cards;
  final ConnectivityResult connectivity;

 ComplexListState copyWith({
   ComplexStatus? status,
   List<Card>? cards,
   ConnectivityResult? connectivity,
 }){
   return ComplexListState(
     status: status ?? this.status,
     cards: cards ?? this.cards,
     connectivity: connectivity ?? this.connectivity,
   );
 }     

  @override
  List<Object?> get props => [status, cards , connectivity ];
}

