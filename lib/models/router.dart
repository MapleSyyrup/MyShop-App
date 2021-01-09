import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_products_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/products-overview':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProductsOverviewScreen());
      case '/product-detail':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProductDetailScreen());
      case '/cart':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => CartScreen());
      case '/orders':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => OrdersScreen());
      case '/user-products':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => UserProductsScreen());
      case '/edit-product':
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => EditProductScreen());
      default:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProductsOverviewScreen());
    }
  }
}
