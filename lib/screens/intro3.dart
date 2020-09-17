import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/screens/login.dart';

class Intro3 extends StatelessWidget {
  static const routeName = '/intro3';

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
                  """a lot of food is wasted everyday, we aim to give that food a second chance and distribute it for free to those who want to save the planet""",
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
                    Login.routeName,
                  )
                },
            'get started'),
        elevation: 0,
      ),
    );
  }
}
