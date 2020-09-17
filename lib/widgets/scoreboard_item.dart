import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/providers/user.dart';

class ScoreBoardItem extends StatelessWidget {
  final User user;
  final int index;
  ScoreBoardItem(this.user, this.index);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: BuildText('${index + 1}', null),
            ),
            Icon(
              Icons.person,
              size: 50.0,
              color: Colors.black,
            ),
            Expanded(
              child: BuildText('CatSlayer01', null),
            ),
            Expanded(
              child: BuildText('${user.score}', null),
            ),
          ],
        ));
  }
}
