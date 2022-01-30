part of 'complex_list_bloc.dart';

enum ComplexStatus { loading, success, failure }

class ComplexListState extends Equatable {
  const ComplexListState({
    this.status = ComplexStatus.loading,
    this.items = const <Item>[],
    this.connectivity = ConnectivityResult.mobile,
  });

  final ComplexStatus status;
  final List<Item> items;
  final ConnectivityResult connectivity;

  ComplexListState copyWith({
    ComplexStatus? status,
    List<Item>? items,
    ConnectivityResult? connectivity,
  }) {
    return ComplexListState(
      status: status ?? this.status,
      items: items ?? this.items,
      connectivity: connectivity ?? this.connectivity,
    );
  }

  bool get hasConnectivity =>
      connectivity == ConnectivityResult.mobile ||
      connectivity == ConnectivityResult.wifi;

  @override
  List<Object> get props => [status, items, connectivity];
}
