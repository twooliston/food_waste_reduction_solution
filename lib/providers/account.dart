import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  String username;
  String firstName;
  String lastName;
  String password;
  String imageURL;
  List awards;
  int score;
  int items;
  String saved;
  String pollution;

  Account({
    @required this.username,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
    @required this.imageURL,
    this.awards,
    @required this.score,
    @required this.items,
    @required this.saved,
    @required this.pollution,
  });
}