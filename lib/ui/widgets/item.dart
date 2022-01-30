import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final int id;
  final String text;

  const ItemWidget({
    Key? key,
    required this.id,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blueGrey[700],
      ),
      child: ListTile(
        title: Text('ID $id', style: const TextStyle(color: Colors.white)),
        subtitle: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
