import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String id;
  List rewards;
  String score;
  String items;
  String saved;
  String pollution;

  User({
    this.id,
    this.rewards,
    this.score,
    this.items,
    this.saved,
    this.pollution,
  });
}