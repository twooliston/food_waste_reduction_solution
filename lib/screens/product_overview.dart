import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import 'edit_product_screen.dart';
import 'nav_bar.dart';
import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/generic_widgets/text.dart';

import '../providers/products_provider.dart';

class OverviewScreen extends StatefulWidget {
  static const routeName = '/overview';

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).getProducts().then((_) {
        setState(() {
        _isLoading = false;
      });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildOverview(context),
      bottomNavigationBar: BottomAppBar(
        child:
        BuildButton(
            () => Navigator.of(context).pushNamed(
                  EditProductDetails.routeName,
                  arguments: 'CatSlayer01',
                ),
            'list your own item'),
        elevation: 0,
      ),
    );
  }

  Widget _buildOverview(context) {
    return RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: ListView(
        children: <Widget>[
          _buildHeader(context),
          ProductsGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
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
              _buildAccount(context),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: BuildText('what\'s available around you right now?', null),
          ),
        ],
      ),
    );
  }

  Widget _buildAccount(context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        NavBar.routeName,
        arguments: 'CatSlayer01',
      ),
      child: Icon(
        Icons.person,
        size: 50.0,
        color: Colors.black,
      ),
    );
  }
}
