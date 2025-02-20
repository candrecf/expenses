import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

// enum Colors {
//   red,
//   purple,
//   orange,
//   blue,
//   black,
// }

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final Function(String p1) onRemove;

  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          // backgroundColor: Theme.of(context).primaryColor,
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headlineSmall,
          // style: TextStyle(
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                onPressed: () => widget.onRemove(widget.tr.id),
                label: Text('Excluir'),
                style: ButtonStyle(
                  foregroundColor:
                      WidgetStateProperty.all<Color>(Colors.red[700]!),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red[700],
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
    );
  }
}
