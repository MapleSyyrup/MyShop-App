import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

///Screen for list of orders
class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final orderDt = orderData.orders;
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderDt.length,
        itemBuilder: (ctx, i) => OrderItem(order: orderDt[i]),
      ),
    );
  }
}
