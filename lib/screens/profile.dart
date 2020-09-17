import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/label.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/widgets/product_item.dart';
import 'package:food_waste/screens/settings.dart';
import 'package:food_waste/screens/user_product_details.dart';

import '../providers/accounts_provider.dart';
import '../providers/products_provider.dart';
import '../providers/orders_provider.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isUserPage = true;
  int navSelected;
  var _isLoading = false;

  void _onItemTapped(bool state) {
    setState(() {
      isUserPage = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    //fake data for username and account details on settings page
    final username = ModalRoute.of(context).settings.arguments as String;
    final account = Provider.of<Accounts>(
      context,
      listen: false,
    ).findById(username);

    // real data for the stats
    final user = Provider.of<Orders>(context).account;

    if (isUserPage) {
      return _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
        children: <Widget>[
          _buildHeader(context, account),
          _buildUserRating(),
          _buildScoreModule(user),
          _buildInfoModules(user),
        ],
      );
    }
    return ListView(
      children: <Widget>[
        _buildHeader(context, account),
        _userShop(context),
      ],
    );
  }

  Widget _buildHeader(context, account) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 15.0,
        bottom: 20.0,
      ),
      color: Theme.of(context).accentColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BuildBackArrow(context),
              _buildSettings(account.username),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTapped(true),
                  child: _buildUser(account),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTapped(false),
                  child: _buildShop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUser(account) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        top: 10.0,
        bottom: 20.0,
      ),
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 10.0,
      ),
      height: 150,
      color: isUserPage
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              size: 50.0,
              color: Colors.black,
            ),
          ),
          BuildText(account.username, null),
        ],
      ),
    );
  }

  Widget _buildShop() {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        top: 10.0,
        bottom: 20.0,
      ),
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 10.0,
      ),
      height: 150,
      color: !isUserPage
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart,
              size: 50.0,
              color: Colors.black,
            ),
          ),
          BuildText('shop', null),
        ],
      ),
    );
  }

  Widget _userShop(BuildContext context) {
    final products = Provider.of<Products>(context).userProducts();
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: const EdgeInsets.all(40),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(UserProductDetails.routeName),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }

  Widget _buildUserRating() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.star,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.star,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.star,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.star,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.star_half,
                  size: 50.0,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildScoreModule(user) {
    return Container(
      padding: EdgeInsets.only(
        left: 100.0,
        right: 100.0,
        bottom: 10.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildBlocks('Score', user.score, 35.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoModules(user) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildBlocks('items', user.items, null),
              ),
              Expanded(
                child: _buildBlocks('saved', '£${user.saved}', null),
              ),
              Expanded(
                child: _buildBlocks(
                    'pollution prevented', '${user.pollution}μg', null),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBlocks(label, text, size) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 20.0,
      ),
      height: 125,
      color: Theme.of(context).accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BuildLabel(label),
          BuildText(text, size),
        ],
      ),
    );
  }

  Widget _buildSettings(username) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Settings.routeName,
        arguments: username,
      ),
      child: Icon(
        Icons.settings,
        size: 50.0,
        color: Colors.black,
      ),
    );
  }
}
