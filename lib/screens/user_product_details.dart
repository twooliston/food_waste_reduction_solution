import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/label.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/generic_widgets/longText.dart';
import 'package:food_waste/screens/edit_product_screen.dart';

class UserProductDetails extends StatelessWidget {
  static const routeName = '/user-product-details';

  _deleteProduct(context, id) {
    // TODO: imporve with await and a try + cacth
    Provider.of<Products>(context, listen: false).deleteProduct(id);
    Navigator.of(context).pop();
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
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        child: Row(children: <Widget>[
          SizedBox(height: 75.0),
          Expanded(
            child: GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed(
                  EditProductDetails.routeName,
                  arguments: productId,
                ),
              },
              child: Icon(
                Icons.edit,
                size: 50.0,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => {_deleteProduct(context, product.id)},
              child: Icon(
                Icons.delete,
                size: 50.0,
                color: Colors.black,
              ),
            ),
          ),
        ]),
        elevation: 0,
      ),
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
        ],
      ),
    );
  }
}
