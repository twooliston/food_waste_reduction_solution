import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/generic_widgets/label.dart';
import 'package:food_waste/generic_widgets/text.dart';

import 'package:food_waste/providers/accounts_provider.dart';

class AccountDetails extends StatelessWidget {
  static const routeName = '/account-details';
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
      bottomNavigationBar: BottomAppBar(
        child: BuildButton(
            () => {},
            'edit details'),
        elevation: 0,
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
                child: BuildText('account details', null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    final username = ModalRoute.of(context).settings.arguments as String;
    final account = Provider.of<Accounts>(
      context,
      listen: false,
    ).findById(username);
    return Container(
      padding: EdgeInsets.only(
        left: 75.0,
        right: 75.0,
        top: 50.0,
        bottom: 20.0,
      ),
      child: Column(
        children: <Widget>[
          _accountItem('username', account.username),
          _accountItem('firstname', account.firstName),
          _accountItem('lastname', account.lastName),
          _accountItem('password', account.password),
        ],
      ),
    );
  }

  Widget _accountItem(String label, String text) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: <Widget>[
          BuildLabel(label),
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
