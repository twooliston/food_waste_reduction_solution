import 'dart:convert';

import 'package:flutter/material.dart';
import './account.dart';

import 'package:http/http.dart' as http;
import 'package:food_waste/providers/user.dart';

class Accounts with ChangeNotifier {
  final String authToken;
  final String userId;
  List<User> _userAccounts = [];

  Accounts(this.authToken, this.userId, this._userAccounts);
  List<Account> _items = [
    Account(
      username: 'CatSlayer01',
      firstName: 'Josh',
      lastName: 'Smith',
      password: 'password',
      awards: [],
      score: 10528,
      items: 7,
      saved: '£30',
      pollution: '1.5Kg',
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Account(
      username: 'CatSlayer02',
      firstName: 'Mark',
      lastName: 'Smith',
      password: 'password',
      awards: [],
      score: 1052,
      items: 7,
      saved: '£30',
      pollution: '1.5Kg',
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Account(
      username: 'CatSlayer03',
      firstName: 'Barry',
      lastName: 'Smith',
      password: 'password',
      awards: [],
      score: 20528,
      items: 7,
      saved: '£30',
      pollution: '1.5Kg',
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
  ];

  List<Account> get items {
    return [..._items];
  }

  List<Account> get itemsOrdered {
    List<Account> listToSort = [..._items];
    listToSort.sort((b, a) => a.score.compareTo(b.score));
    return listToSort;
  }

  List<User> get usersOrdered {
    List<User> listToSort = _userAccounts;
    listToSort.sort((b, a) => int.parse(a.score).compareTo(int.parse(b.score)));
    return listToSort;
  }

  Account findById(String username) {
    return _items.firstWhere((acc) => acc.username == username);
  }

  List<User> get userAccounts {
    return _userAccounts;
  }

  Future<void> getUsers() async {
    final url =
        'https://food-waste-reduction-system.firebaseio.com/users.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(
        response.body,
      ) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      
      extractedData.forEach((userId, userData) {
        if (_userAccounts.where((user) => user.id == userId).isEmpty) {
          _userAccounts.add(
            User(
              id: userId,
              rewards: userData['rewards'],
              score: userData['score'],
              items: userData['items'],
              saved: userData['saved'],
              pollution: userData['pollution'],
            ),
          );
        }
      });
      return _userAccounts;
    } catch (error) {
      throw (error);
    }
  }
}
