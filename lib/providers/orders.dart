import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myshop_app/models/constants.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double? amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

///List of _orders
class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  ///getter of _orders
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse('${Constants.url}/orders/$userId.json?auth=$authToken');

    final List<OrderItem> loadedOrders = [];
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>?;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((String orderId, dynamic orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'] as double?,
          dateTime: DateTime.parse(orderData['dateTime'].toString()),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (dynamic item) => CartItem(
                  id: item['id'].toString(),
                  title: item['title'].toString(),
                  quantity: item['quantity'] as int?,
                  price: item['price'] as double?,
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  ///Function for adding an order
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse('${Constants.url}/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body).toString(),
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
