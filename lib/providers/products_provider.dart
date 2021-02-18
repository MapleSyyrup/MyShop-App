import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/constants.dart';
import 'product.dart';

///List of products
class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  ///getter of _items
  List<Product> get items {
    return [..._items];
  }

  ///getter of favorited products
  List<Product> get favoriteItems => _items.where((prodItem) => prodItem.isFavorite).toList();

  ///Returns the first product id that is the same with id
  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  Future<void> fetchAndSetProducts() async {
    final url = Constants.url;
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
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
    try {
      final response = await http.post(
        Constants.url,
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
  void updateProduct(Product product) {
    _items[_items.indexWhere((prod) => prod.id == product.id)] = product;
    notifyListeners();
  }

  ///Deletes a product in the list
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
