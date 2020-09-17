import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/providers/reward.dart';

class RewardItem extends StatelessWidget {
  final Reward reward;
  final IconData icon;
  RewardItem(this.reward, this.icon);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Row(
            children: <Widget>[
              Icon(
                  icon,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              Expanded(
                child: BuildText(reward.description, null),
              ),
            ],
          )
    );
  }
}
