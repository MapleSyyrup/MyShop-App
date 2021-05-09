import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

///Screen for the list of products added by the user
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  ///Refreshes the list of products from the database
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // print('rebuilding...');
    // final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(EditProductScreen.routeName),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<ProductsProvider>(
                  builder: (ctx, productsData, _) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: productsData.items.length,
                      itemBuilder: (_, i) {
                        final productsDt = productsData.items[i];
                        return Column(
                          children: [
                            UserProductItem(
                              id: productsDt.id,
                              title: productsDt.title,
                              imageUrl: productsDt.imageUrl,
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
