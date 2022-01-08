import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final int id;
  final String text;

  const Item({
    Key? key,
    required this.id,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTextStyle(
        //   style: Theme.of(context).textTheme.bodyText1!,
        // child  :
        Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blueGrey[700],
      ),
      child: ListTile(
        title: Text('ID $id', style: const TextStyle(color: Colors.white)),
        subtitle: Text(text, style: const TextStyle(color: Colors.white)),
      ),
      //  , )
    );
  }
}
