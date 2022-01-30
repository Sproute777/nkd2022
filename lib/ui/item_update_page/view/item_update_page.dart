import 'package:bloc_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui.dart';
import 'item_update_form.dart';

class ItemUpdatePage extends StatelessWidget {
  static Route route({
    required Item item,
  }) {
    return MaterialPageRoute<void>(builder: (_) => ItemUpdatePage(item));
  }

  final Item item;

  const ItemUpdatePage(this.item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
          lazy: false,
          create: (_) =>
              ItemUpdateBloc(complexListBloc: context.read<ComplexListBloc>())
                ..add(ItemUpdateItemChanged(
                  id: item.id,
                  row: item.row.index.toString(),
                  seqNum: item.seqNum,
                  text: item.text,
                )),
          child: ItemUpdateForm(item.text)),
    );
  }
}
