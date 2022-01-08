import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../complex.dart';

class ThirdTabPage extends StatelessWidget {
  const ThirdTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplexListBloc, ComplexListState>(
      builder: (context, state) {
        switch (state.status) {
          case ComplexStatus.failure:
            return const Center(
              child: Text('Error'),
            );
          case ComplexStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ComplexStatus.success:
            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (BuildContext context, int index) {
                return state.cards[index].row == 2
                    ? Item(
                        id: state.cards[index].id,
                        text: state.cards[index].text)
                    : const SizedBox();
              },
            );
        }
      },
    );
  }
}
