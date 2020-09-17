import 'package:flutter/material.dart';
import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/text.dart';

class Contact extends StatelessWidget {
  static const routeName = '/contact';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 35.0,
        bottom: 60.0,
      ),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              BuildBackArrow(context),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: BuildText('contact us', null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 75.0,
        right: 75.0,
        top: 50.0,
        bottom: 20.0,
      ),
      child: Column(
        children: <Widget>[
          _settingsItem('this area is in development'),
          _settingsItem('and coming soon!'),
        ],
      ),
    );
  }

  Widget _settingsItem(String text) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: BuildText(text, null),
          ),
        ],
      ),
    );
  }
}
