import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../complex.dart';

class SlidableItem extends StatelessWidget {
  final Item item;
  const SlidableItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          const SlidableAction(
            onPressed: _editItem,
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              context.read<ComplexListBloc>().add(DeleteComplexItem(item.id));
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ItemWidget(
        id: item.id,
        text: item.text,
      ),
    );
  }
}

void _editItem(BuildContext context) {}