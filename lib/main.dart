import 'package:flutter/material.dart';
import 'package:myshop_app/providers/orders.dart';
import 'package:provider/provider.dart';

import './models/custom_colors.dart';
import './models/router.dart';
import './providers/cart.dart';
import './providers/products_provider.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: primaryTheme,
          accentColor: accentTheme,
          canvasColor: canvasTheme,
          fontFamily: 'Lato',
        ),

        ///First screen to show
        initialRoute: ProductsOverviewScreen.routeName,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
