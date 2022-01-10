part of 'complex_list_bloc.dart';

abstract class ComplexListEvent extends Equatable {
  @override
  List<Object> get props => [];
}
//----------------------------------------------------------------------------

class LoadComplexList extends ComplexListEvent {}
//----------------------------------------------------------------------------

class CreateComplexItem extends ComplexListEvent {
  final int row;
  final String text;

  CreateComplexItem({required this.row, required this.text});

  @override
  List<Object> get props => [row, text];
}
//----------------------------------------------------------------------------

class UpdateComplexItem extends ComplexListEvent {
  final Item card;

  UpdateComplexItem({required this.card});
  @override
  List<Object> get props => [card];
}
//----------------------------------------------------------------------------

class DeleteComplexItem extends ComplexListEvent {
  final int id;

  DeleteComplexItem(this.id);

  @override
  List<Object> get props => [id];
}
//----------------------------------------------------------------------------

class ConnectivityComplexChanged extends ComplexListEvent {
  ConnectivityComplexChanged(this.result);
  final ConnectivityResult result;
  @override
  List<Object> get props => [result];
}
