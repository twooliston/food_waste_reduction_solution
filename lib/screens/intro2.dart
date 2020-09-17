import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/screens/intro3.dart';

class Intro2 extends StatelessWidget {
  static const routeName = '/intro2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 7,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(
                left: 50.0,
                right: 50.0,
              ),
              child: BuildText(
                  """if grouped as its own country, food waste produces the world's 3rd highest emissions after USA and China!!""",
                  null),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BuildButton(
            () => {
                  Navigator.of(context).pushNamed(
                    Intro3.routeName,
                  )
                },
            'continue'),
        elevation: 0,
      ),
    );
  }
}
