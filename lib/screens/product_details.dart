import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/label.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/generic_widgets/longText.dart';
import 'package:food_waste/generic_widgets/button.dart';

import '../providers/products_provider.dart';
import 'package:food_waste/providers/orders_provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/product-details';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var _isLoading = false;

  Future<void> reserve(context, product) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Orders>(context, listen: false).reserve(product);
      try {
        await Provider.of<Products>(context, listen: false)
            .reserveProduct(product.id);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Theme.of(context).accentColor,
            content: Text(
                "you just prevented some pollution from affecting ourt planet! thank you for your help <3"),
            actions: <Widget>[
              FlatButton(
                child: Text('collect food', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('updating error'),
            content: Text(
                'there was an issue updating the reserved product, please try again'),
            actions: <Widget>[
              FlatButton(
                child: Text('okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('saving error'),
          content: Text(
              'there was an issue reserving the product, please try again'),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopHalf(context, product),
            _buildBottomHalf(product),
          ],
        ),
      ),
      bottomNavigationBar: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : product.available
              ? BottomAppBar(
                  child:
                      BuildButton(() => reserve(context, product), 'reserve'),
                  elevation: 0,
                )
              : null,
    );
  }

  Widget _buildTopHalf(context, product) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 35.0,
        bottom: 10.0,
      ),
      height: 405,
      color: Theme.of(context).accentColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildBackArrow(context),
          _buildProductPhoto(product),
        ],
      ),
    );
  }

  Widget _buildProductPhoto(product) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 20.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          product.imageURL,
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBottomHalf(product) {
    return Container(
      padding: EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5.0),
          BuildText(product.name, 25.0),
          SizedBox(height: 40.0),
          BuildLabel('DESCRIPTION'),
          SizedBox(height: 5.0),
          BuildLongText(product.description, 25.0),
          SizedBox(height: 40.0),
          BuildLabel('WALKING DISTANCE'),
          SizedBox(height: 5.0),
          BuildLongText('feature coming soon!', 25.0),
        ],
      ),
    );
  }
}
