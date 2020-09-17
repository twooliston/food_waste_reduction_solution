import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  String name;
  String description;
  int distance;
  String imageURL;
  String creatorId;
  bool available;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.distance,
    @required this.imageURL,
    @required this.creatorId,
    @required this.available,
  });
}
