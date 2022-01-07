import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../complex.dart';

class ThirdTabPage extends StatelessWidget {
  const ThirdTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplexListBloc, ComplexListState>(
      builder: (context, state) {
        context.read<ComplexListBloc>().add(LoadComplexList());
        if (state.status == ComplexStatus.success) {
          // const Center(child: CircularProgressIndicator());

          return ListView.builder(
            itemCount: state.cards.length,
            itemBuilder: (BuildContext context, int index) {
              return state.cards[index].row == 2
                  ? Item(
                      id: state.cards[index].id, text: state.cards[index].text)
                  : const SizedBox();
            },
          );
        } else {
          return Text('');
        }
        // return const Center(
        // child: Text('TEXT'),
        // );
      },
    );
  }
}
