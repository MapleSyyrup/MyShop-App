import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({
    @required this.title,
    @required this.imageUrl,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: EditProductArguments(productId: id),
              ),
              color: theme.primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => Provider.of<ProductsProvider>(context, listen: false).deleteProduct(id),
              color: theme.errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
