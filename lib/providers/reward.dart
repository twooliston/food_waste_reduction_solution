import 'package:flutter/foundation.dart';

// set up rewards
class Reward with ChangeNotifier {
  int id;
  String description;
  String imageURL;

  Reward({
    @required this.id,
    @required this.description,
    @required this.imageURL,
  });
}