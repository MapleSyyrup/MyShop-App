import 'package:flutter/material.dart';
import 'package:myshop_app/providers/auth.dart';
import 'package:myshop_app/providers/orders.dart';
import 'package:myshop_app/screens/auth_screen.dart';
import 'package:myshop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import './models/custom_colors.dart';
import './models/router.dart';
import './providers/cart.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (ctx, auth, previousProducts) {
            return ProductsProvider(auth.token, auth.userId, previousProducts == null ? [] : previousProducts.items);
          },
          // ProductsProvider(auth.token ),
          create: (_) => ProductsProvider(
            null,
            null,
            [],
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(
                  null,
                  null,
                  [],
                ),
            update: (ctx, auth, previousOrder) =>
                Orders(auth.token, auth.userId, previousOrder == null ? [] : previousOrder.orders)),
        // ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: primaryTheme,
            accentColor: accentTheme,
            canvasColor: canvasTheme,
            fontFamily: 'Lato',
          ),

          ///First screen to show
          initialRoute: firstScreen(auth),
          onGenerateRoute: Routers.generateRoute,
        ),
      ),
    );
  }

  String firstScreen(Auth auth) => auth.isAuth ? ProductsOverviewScreen.routeName : AuthScreen.routeName;
}
