import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myshop_app/models/constants.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double? price;
  final String imageUrl;
  bool isFavorite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  ///If the favorite button is pressed, the item will be added as favorite
  Future<void> toggleFavoriteStatus(String? token, String? userId) async {
    final oldStatus = isFavorite;
    final newValue = !isFavorite;
    final url = Uri.parse('${Constants.url}/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(newValue),
      );
      _setFavValue(response.statusCode >= 400 ? oldStatus : newValue);
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
