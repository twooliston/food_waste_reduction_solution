import 'package:flutter/material.dart';
import 'package:food_waste/generic_widgets/text.dart';
import 'package:food_waste/providers/product.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/button.dart';

class EditProductDetails extends StatefulWidget {
  static const routeName = '/edit-product-details';

  @override
  _EditProductDetailsState createState() => _EditProductDetailsState();
}

class _EditProductDetailsState extends State<EditProductDetails> {
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    name: '',
    description: """""",
    distance: null,
    imageURL: '',
    creatorId: '',
    available: true,
  );
  var _intiValues = {
    'imageURL': '',
    'name': '',
    'description': '',
  };
  var _isInit = true;
  var _isLoading = false;

  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final contextData = ModalRoute.of(context).settings.arguments as String;
      if (contextData.startsWith('-')) {
        // all id strings start with a '-' and usernames are not allowed to start with a '-'
        _editedProduct = Provider.of<Products>(
          context,
          listen: false, //may need to listen later
        ).findById(contextData);
        _intiValues = {
          'imageURL': _editedProduct.imageURL,
          'name': _editedProduct.name,
          'description': _editedProduct.description,
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void dispose() {
    _imageFocusNode.removeListener(_updateImage);
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg') &&
              !_imageUrlController.text.endsWith('png'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedProduct.id != null) {
        try {
          await Provider.of<Products>(context, listen: false)
              .updateProduct(_editedProduct);
        } catch (error) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('updating error'),
              content: Text(
                  'there was an issue updating the product, please try again'),
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
        } finally {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_editedProduct, context);
        } catch (error) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('saving error'),
              content: Text(
                  'there was an issue saving the product, please try again'),
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
        } finally {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  _buildTopHalf(context, _editedProduct),
                  _buildBottomHalf(_editedProduct)
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: BuildButton(() => _saveForm(), 'save'),
        elevation: 0,
      ),
    );
  }

  Widget _buildTopHalf(context, product) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 15.0,
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
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: _imageUrlController.text.isEmpty
          ? BuildText('no image', null)
          : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                _imageUrlController.text,
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
          TextFormField(
            decoration: InputDecoration(labelText: 'image url'),
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter an image url';
              } else if (!value.startsWith('http') &&
                  !value.startsWith('https')) {
                return 'please enter a valid image url';
              } else if (!value.endsWith('jpg') &&
                  !value.endsWith('jpeg') &&
                  !value.endsWith('png')) {
                return 'please enter a valid picture format';
              }
              return null;
            },
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            controller: _imageUrlController,
            focusNode: _imageFocusNode,
            onSaved: (value) {
              _editedProduct = Product(
                id: _editedProduct.id,
                imageURL: value,
                name: _editedProduct.name,
                description: _editedProduct.description,
                distance: _editedProduct.distance,
                creatorId: _editedProduct.creatorId,
                available: _editedProduct.available,
              );
            },
          ),
          SizedBox(height: 5.0),
          TextFormField(
            initialValue: _intiValues['name'],
            decoration: InputDecoration(labelText: 'name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter a name';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocusNode);
            },
            onSaved: (value) {
              _editedProduct = Product(
                id: _editedProduct.id,
                imageURL: _editedProduct.imageURL,
                name: value,
                description: _editedProduct.description,
                distance: _editedProduct.distance,
                creatorId: _editedProduct.creatorId,
                available: _editedProduct.available,
              );
            },
          ),
          TextFormField(
            initialValue: _intiValues['description'],
            decoration: InputDecoration(labelText: 'description'),
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter a description';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            focusNode: _descriptionFocusNode,
            onSaved: (value) {
              _editedProduct = Product(
                id: _editedProduct.id,
                imageURL: _editedProduct.imageURL,
                name: _editedProduct.name,
                description: value,
                distance: _editedProduct.distance,
                creatorId: _editedProduct.creatorId,
                available: _editedProduct.available,
              );
            },
          ),
        ],
      ),
    );
  }
}
