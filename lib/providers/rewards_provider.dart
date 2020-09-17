import 'package:flutter/material.dart';

import 'reward.dart';


class Rewards with ChangeNotifier {
  List<Reward> _items = [
    Reward(
      id: 0000,
      description: """new account""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0001,
      description: """1st reserve""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0002,
      description: """1st listing""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0003,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0004,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0005,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0006,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0007,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0008,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0009,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0010,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0011,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0012,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0013,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
    Reward(
      id: 0014,
      description: """more rewards coming soon""",
      imageURL:
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/masala-pasta-500x500.jpg',
    ),
  ];

  List<Reward> get items {
    return [..._items];
  }

  Reward findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
