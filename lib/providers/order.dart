import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  final String id;
  String name;
  String creatorId;

  Order({
    @required this.id,
    @required this.name,
    @required this.creatorId,
  });
}
