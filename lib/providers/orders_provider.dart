import 'package:flutter/material.dart';
import 'package:food_waste/providers/order.dart';
import 'package:food_waste/providers/user.dart';
import 'dart:convert';

import './product.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  final String authToken;
  final String userId;
  var accountData = {};
  List<Order> _items = [];
  var accountDetails = User(
    rewards: ['new account'],
    score: '0',
    items: '0',
    saved: '0.00',
    pollution: '0.00',
  );

  Orders(this.authToken, this.userId, this._items);

  Future<void> getOrders() async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(
        response.body,
      ) as Map<String, dynamic>;
      extractedData.forEach((orderId, orderData) {
        if (_items.where((prod) => prod.id == orderId).isEmpty) {
          _items.add(
            Order(
              id: orderId,
              name: orderData['name'],
              creatorId: orderData['creatorId'],
            ),
          );
        }
      });
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Order> get items {
    return [..._items];
  }

  User get account {
    return accountDetails;
  }

  Future<void> reserve(Product product) async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'creatorId': product.creatorId,
        }),
      );

      final newReserve = Order(
        id: json.decode(response.body)['name'],
        name: product.name,
        creatorId: product.creatorId,
      );
      _items.add(newReserve);
      if (await checkIfNewAccount()) {
        await newStats();
      }
      await updateStatsReserve();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> newStats() async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/users/$userId.json?auth=$authToken';
    try {
      await http.patch(
        url,
        body: json.encode({
          'rewards': ['new account'],
          'score': '0',
          'items': '0',
          'saved': '0.00',
          'pollution': '0.00',
        }),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateStatsReserve() async {
    const itemWeight = 0.3; //0.3kg of a portion
    const pollutionPerKilo = 9.43; // 9.43μg per kilo of food

    // update stats logic
    final score = (int.parse(accountDetails.score) + 10).toString();
    final items = (int.parse(accountDetails.items) + 1).toString();
    final saved = (double.parse(accountDetails.saved) + 4.67).toStringAsFixed(2);
    final pollution = (double.parse(items) * itemWeight * pollutionPerKilo)
        .toStringAsFixed(2);
    final rewards = accountDetails.rewards;

    // reward for first listing
    if (!rewards.contains("1st reserve")) {
      rewards.add("1st reserve");
    }

    final url =
        'https://food-waste-reduction-system.firebaseio.com/users/$userId.json?auth=$authToken'; // $dbAccountId not needed anymore? (database bugs)
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'rewards': rewards,
          'score': score,
          'items': items,
          'saved': saved,
          'pollution': pollution,
        }),
      );
      accountDetails = User(
        rewards: rewards,
        score: score,
        items: items,
        saved: saved,
        pollution: pollution,
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateRewards(String newReward) async {
    final rewards = accountDetails.rewards;
    final score = (int.parse(accountDetails.score) + 10).toString();
    accountDetails.score = score;
    
    // add new reward
    if (!rewards.contains(newReward)) {
      rewards.add(newReward);
    }

    final url =
        'https://food-waste-reduction-system.firebaseio.com/users/$userId.json?auth=$authToken'; // $dbAccountId not needed anymore? (database bugs)
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'rewards': rewards,
          'score': score,
        }),
      );
      accountDetails.rewards = rewards;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> checkIfNewAccount() async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/users.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(
        response.body,
      ) as Map<String, dynamic>;

      if (extractedData == null) {
        return true;
      }

      final accountExists = extractedData.containsKey(userId);
      if (accountExists) {
        final data = extractedData[userId];
        accountDetails = User(
          rewards: data['rewards'],
          score: data['score'],
          items: data['items'],
          saved: data['saved'],
          pollution: data['pollution'],
        );
      }
      return !accountExists;
    } catch (error) {
      throw (error);
    }
  }
}
