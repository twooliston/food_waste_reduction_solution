import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_waste/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _userId != null) {
      return _userId;
    }
    return null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _athenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDxcZ83BQfjW3j7BRqbmEkcE8spTVZph9s';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> register(String email, String password, context) async {
    return _athenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _athenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final data = json.decode(
      prefs.getString('userData'),
    ) as Map<String, Object>;
    final expiryDate = DateTime.parse(data['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = data['token'];
    _userId = data['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout(context) async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    // TODO: Fix this
    // notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.of(context).pushReplacementNamed('/');
  }
}
