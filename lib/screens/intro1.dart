import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/screens/intro2.dart';

class Intro1 extends StatelessWidget {
  static const routeName = '/intro1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BuildButton(
            () => {
                  Navigator.of(context).pushNamed(
                    Intro2.routeName,
                  )
                },
            'save the planet'),
        elevation: 0,
      ),
    );
  }
}
