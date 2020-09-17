import 'package:flutter/material.dart';
import 'package:food_waste/providers/orders_provider.dart';
import 'package:provider/provider.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/widgets/reward_item.dart';

import '../providers/rewards_provider.dart';
import 'package:food_waste/providers/user.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  bool _isLoading = false;
  User user;
  @override
  Widget build(BuildContext context) {
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
                child: BuildText('rewards', null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    final rewards = Provider.of<Rewards>(context).items;
    List userHasReward = [];
    List arrayOfRewards = [];
    bool temp = false;
    createRewards();
    
    if (user != null) {
      for (var i = 0; i < rewards.length; i++) {
        arrayOfRewards.add(rewards[i].description);
      }

      for (var i = 0; i < rewards.length; i++) {
        for (var j = 0; j < user.rewards.length; j++) {
          temp = arrayOfRewards[i] == user.rewards[j];
          if (temp) {
            break;
          }
        }
        userHasReward.add(temp);
      }
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: const EdgeInsets.all(40),
            itemCount: rewards.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: rewards[i],
              child: RewardItem(rewards[i], userHasReward[i] ? Icons.star : Icons.star_border),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 5,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
          );
  }

  Future<void> createRewards() async {
    if (user == null) {
      setState(() {
        _isLoading = true;
      });
      if (await Provider.of<Orders>(context, listen: false)
          .checkIfNewAccount()) {
        await Provider.of<Orders>(context, listen: false).newStats();
      }
      user = Provider.of<Orders>(context, listen: false).account;
      setState(() {
        _isLoading = false;
      });
    }
  }
}
