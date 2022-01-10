import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../complex/complex.dart';
import '../item_editor.dart';
import 'item_editor_form.dart';

class ItemEditorPage extends StatelessWidget {
  static Route route(int row) {
    return MaterialPageRoute<void>(builder: (_) => ItemEditorPage(row));
  }

  final int row;
  const ItemEditorPage(this.row, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
          lazy: true,
          create: (_) =>
              ItemEditorBloc(complexListBloc: context.read<ComplexListBloc>())
                ..add(ItemEditorRowChanged(row)),
          child: const ItemEditorForm()),
    );
  }
}