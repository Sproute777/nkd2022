import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../complex.dart';

class FirstTabPage extends StatelessWidget {
  const FirstTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplexListBloc, ComplexListState>(
        // buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
      // context.read<ComplexListBloc>().add(LoadComplexList());
      switch (state.status) {
        case ComplexStatus.failure:
          return const Center(
            child: Text('Error'),
          );

        case ComplexStatus.loading:
          return const Center(child: CircularProgressIndicator());

        case ComplexStatus.success:
          var cards =
              state.cards.where((element) => element.row == '0').toList();
          return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return Item(id: cards[index].id, text: cards[index].text);
              });
      }
    });
  }
}
