import 'package:flutter/material.dart';
import 'package:food_waste/providers/user.dart';
import 'package:provider/provider.dart';

import '../widgets/scoreboard_item.dart';
import '../providers/accounts_provider.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/text.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  bool _isLoading = false;
  List<User> _userAccounts = [];

  @override
  Widget build(BuildContext context) {
    createScoreboard();
    return ListView(
      children: <Widget>[
        _buildHeader(context),
        _buildBody(context),
      ],
    );
  }

  Widget _buildHeader(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 15.0,
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
                child: BuildText('scoreboard', null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: const EdgeInsets.all(40),
            itemCount: _userAccounts.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: _userAccounts[i],
              child: ScoreBoardItem(_userAccounts[i], i),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 5,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
          );
  }

  Future<void> _getUsers(BuildContext context) async {
    await Provider.of<Accounts>(context, listen: false).getUsers();
  }

  Future<void> createScoreboard() async {
    if (_userAccounts.length == 0) {
      setState(() {
        _isLoading = true;
      });
      await _getUsers(context);
      _userAccounts =
          Provider.of<Accounts>(context, listen: false).usersOrdered;
      setState(() {
        _isLoading = false;
      });
    }
  }
}
