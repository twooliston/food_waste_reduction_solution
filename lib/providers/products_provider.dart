import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import './product.dart';
import 'package:food_waste/models/http_exception.dart';
import 'package:http/http.dart' as http;

import 'orders_provider.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String creatorId;
  List<Product> _items = [];

  Products(this.authToken, this.creatorId, this._items);

  Future<void> getProducts() async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(
        response.body,
      ) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        if (_items.where((prod) => prod.id == prodId).isEmpty) {
          _items.add(
            Product(
              id: prodId,
              name: prodData['name'],
              description: prodData['description'],
              distance: prodData['distance'],
              imageURL: prodData['imageURL'],
              creatorId: prodData['creatorId'],
              available: prodData['available'],
            ),
          );
        }
      });
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> userProducts() {
    // move server side with url add "&orderBy="creatorId"&equalTo="$userId""
    // https://learning.oreilly.com/videos/learn-flutter-and/9781789951998/9781789951998-video11_12
    return [..._items.where((prod) => prod.creatorId == creatorId)];
  }

  Future<void> addProduct(Product product, context) async {
    await Provider.of<Orders>(context, listen: false).updateRewards('1st listing');

    final url =
        'https://food-waste-reduction-system.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'description': product.description,
          'distance': product.distance,
          'imageURL': product.imageURL,
          'creatorId': creatorId,
          'available': true,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        name: product.name,
        description: product.description,
        distance: product.distance,
        imageURL: product.imageURL,
        creatorId: creatorId,
        available: true,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProduct(Product product) async {
    final id = product.id;
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url =
          'https://food-waste-reduction-system.firebaseio.com/products/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'name': product.name,
              'description': product.description,
              'distance': product.distance,
              'imageURL': product.imageURL,
            }));
        _items[productIndex] = product;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    }
  }
  
  Future<void> reserveProduct(id) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url =
          'https://food-waste-reduction-system.firebaseio.com/products/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'available': false,
            }));
        _items[productIndex].available = false;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/products/$id.json?auth=$authToken';
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw HttpException('could not delete product');
    }
    final index = _items.indexWhere((prod) => prod.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}
