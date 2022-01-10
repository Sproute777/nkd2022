import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../complex/complex.dart';
import '../item_editor.dart';
import 'card_editor_form.dart';

class CardEditorPage extends StatelessWidget {
  static Route route(int row) {
    return MaterialPageRoute<void>(builder: (_) => CardEditorPage(row));
  }

  final int row;
  const CardEditorPage(this.row, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
          lazy: true,
          create: (_) =>
              CardEditorBloc(complexListBloc: context.read<ComplexListBloc>())
                ..add(CardEditorRowChanged(row)),
          child: const CardEditorForm()),
    );
  }
}
