import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = []; ///List of _orders

  List<OrderItem> get orders {
    return [..._orders];
  } ///getter of _orders

  void addOrder(List<CartItem> cartProducts, double total) { ///Function for adding an order
    final date = DateTime.now();
    _orders.insert(
      0,
      OrderItem(
        id: date.toString(),
        amount: total,
        dateTime: date,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
