import 'package:flutter/material.dart';
import 'package:myshop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/Products-Overview';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

///Function that shows only the favorited products
class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  void showOnlyFavorites(FilterOptions selectedValue) {
    setState(() {
      _showOnlyFavorites = selectedValue == FilterOptions.favorites;
    });
  }

  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: showOnlyFavorites,
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return Badge(
                value: cart.itemCount.toString(),
                child: ch,
              );
            },
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
