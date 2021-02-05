import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart'; ///Route name for the navigator

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final primaryTextTheme = Theme.of(context).primaryTextTheme.headline1.color;
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: primaryTextTheme),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  FlatButton(
                    onPressed: () { ///If the FlatButton is pressed, the items in the cart will be added in the list of orders
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear(); ///The items in the cart is cleared
                    },
                    textColor: primaryColor,
                    child: Text('Order Now'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder( ///Shows the list of cart items
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) {
                final item = cart.items.values.toList()[i];
                final productId = cart.items.keys.toList()[i];
                return CartItem(
                  id: item.id,
                  price: item.price,
                  quantity: item.quantity,
                  title: item.title,
                  productId: productId,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
