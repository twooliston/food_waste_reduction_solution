import 'package:flutter/material.dart';

import 'package:food_waste/screens/accountDetails.dart';
import 'package:food_waste/screens/contact.dart';
import 'package:food_waste/screens/notifications.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/text.dart';

import 'package:food_waste/providers/auth.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
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
                child: BuildText('settings', null),
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
          _settingsItem(_accountIcon(), 'account details',
              AccountDetails.routeName, context),
          _settingsItem(_notificationIcon(), 'notifications',
              Notifications.routeName, context),
          _settingsItem(
              _contactIcon(), 'contact us', Contact.routeName, context),
          _logoutItem(_logoutIcon(), 'log out', context),
        ],
      ),
    );
  }

  Widget _settingsItem(Widget getIcon, String text, String route, context) {
    final username = ModalRoute.of(context).settings.arguments as String;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        route,
        arguments: username,
      ),
      child: getButton(getIcon, text),
    );
  }

  Widget _logoutItem(Widget getIcon, String text, context) {
    return GestureDetector(
      onTap: () => Provider.of<Auth>(
          context,
          listen: false,
        ).logout(context),
      child: getButton(getIcon, text),
    );
  }

  Widget getButton(Widget getIcon, String text) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: <Widget>[
          getIcon,
          Expanded(
            child: BuildText(text, null),
          ),
        ],
      ),
    );
  }

  Widget _notificationIcon() {
    return Icon(
      Icons.notifications,
      size: 50.0,
      color: Colors.black,
    );
  }

  Widget _contactIcon() {
    return Icon(
      Icons.email,
      size: 50.0,
      color: Colors.black,
    );
  }

  Widget _logoutIcon() {
    return Icon(
      Icons.exit_to_app,
      size: 50.0,
      color: Colors.black,
    );
  }

  Widget _accountIcon() {
    return Icon(
      Icons.person,
      size: 50.0,
      color: Colors.black,
    );
  }
}
