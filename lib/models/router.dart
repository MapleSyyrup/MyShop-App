import 'package:flutter/material.dart';
import 'package:myshop_app/screens/auth_screen.dart';

import '../screens/cart_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_products_screen.dart';

/*
Class for named routers for easy reference 
A route generator callback for named routes.
If the named route is not here, the navigator will return the default screen
Arguments are used to pass the information to that route
*/
class Routers {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AuthScreen.routeName:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => AuthScreen());
      case ProductsOverviewScreen.routeName:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProductsOverviewScreen());
      case ProductDetailScreen.routeName:
        final argument = setting.arguments as String;
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ProductDetailScreen(productDetailArgs: argument));
      case CartScreen.routeName:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => CartScreen());
      case OrdersScreen.routeName:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => OrdersScreen());
      case UserProductsScreen.routeName:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => UserProductsScreen());
      case EditProductScreen.routeName:
        final args = setting.arguments as EditProductArguments;
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => EditProductScreen(editProductarguments: args));
      default:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProductsOverviewScreen());
    }
  }
}
