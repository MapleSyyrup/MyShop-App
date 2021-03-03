import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/constants.dart';
import '../models/http_exception.dart';
import 'product.dart';

///List of products
class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  ///getter of _items
  List<Product> get items {
    return [..._items];
  }

  ///getter of favorited products
  List<Product> get favoriteItems => _items.where((prodItem) => prodItem.isFavorite).toList();

  ///Returns the first product id that is the same with id
  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  Future<void> fetchAndSetProducts() async {
    const url = '${Constants.url}/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((String prodId, dynamic prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'].toString(),
          description: prodData['description'].toString(),
          price: prodData['price'] as double,
          isFavorite: prodData['isFavorite'] as bool,
          imageUrl: prodData['imageUrl'].toString(),
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  /// addProduct is called when the user adds a new product in the shop
  Future<void> addProduct(Product product) async {
    final title = product.title;
    final description = product.description;
    final imageUrl = product.imageUrl;
    final price = product.price;
    final isFavorite = product.isFavorite;
    const url = '${Constants.url}/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'price': price,
          'isFavorite': isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body).toString(),
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  ///Updates the product
  Future<void> updateProduct(Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == product.id);

    if (prodIndex >= 0) {
      final urlProdId = '${Constants.url}/products/${product.id}.json';
      await http.patch(urlProdId,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  ///Deletes a product in the list and in the database
  Future<void> deleteProduct(String id) async {
    final urlId = '${Constants.url}/products/$id.json';
    final response = await http.delete(urlId);
    if (response.statusCode >= 400) {
      throw HttpException('Could not delete product.');
    } else {
      final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
      _items.removeAt(existingProductIndex);
      notifyListeners();
    }
  }
}
