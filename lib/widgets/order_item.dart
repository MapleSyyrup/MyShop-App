// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem({@required this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
      children: widget.order.products.map(
        (prod) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prod.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${prod.quantity}x \$${prod.price}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              )
            ],
          );
        },
      ).toList(),
    );
  }
}
