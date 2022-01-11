import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../complex.dart';

class SecondTabPage extends StatelessWidget {
  const SecondTabPage({Key? key}) : super(key: key);

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
            var items = state.items
                .where((element) => element.row == ItemRow.inProgress)
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return SlidableItem(
                    item: items[index],
                  );
                });
        }
      },
    );
  }
}
