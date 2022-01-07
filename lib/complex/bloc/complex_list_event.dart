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

  CreateComplexItem({
    required this.row, 
    required this.text});

  @override
  List<Object> get props => [ row,text];
}
//----------------------------------------------------------------------------

class UpdateComplexItem extends ComplexListEvent {
  final int id;
  final int row;
  final int seqNum;
  final String text;

 UpdateComplexItem({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,});
  @override
  List<Object> get props => [id,row,seqNum, text];
}
//----------------------------------------------------------------------------

class DeleteComplexItem extends ComplexListEvent {
  final int id;

  DeleteComplexItem(this.id);

  @override
  List<Object> get props => [
        id
      ];
}
//----------------------------------------------------------------------------

class ConnectivityComplexChanged extends ComplexListEvent{
  ConnectivityComplexChanged(this.result);
  final ConnectivityResult result;
  @override 
  List<Object> get props => [result];
} 