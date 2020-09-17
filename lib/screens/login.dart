import 'package:flutter/material.dart';

import 'package:food_waste/generic_widgets/button.dart';
import 'package:food_waste/models/http_exception.dart';
import 'package:food_waste/screens/product_overview.dart';

import 'package:provider/provider.dart';
import 'package:food_waste/providers/auth.dart';

enum AuthMode { Register, Login }

class Login extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: AuthCard(),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        //login
        await Provider.of<Auth>(
          context,
          listen: false,
        ).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        //register
        await Provider.of<Auth>(
          context,
          listen: false,
        ).register(
          _authData['email'],
          _authData['password'],
          context,
        );
      }

      Navigator.of(context).pushNamed(
        OverviewScreen.routeName,
        arguments: 'username',
      );
    } on HttpException catch (error) {
      var errorMessage = 'authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'email already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'email is not valid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'email is too short';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'email not found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'password is not valid';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'could not authenticate, please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: buildForm(context),
    );
  }

  Widget buildForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 200.0),
          Row(
            children: <Widget>[
              SizedBox(width: 80.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'enter an email';
                    }
                    if (!value.contains('@')) {
                      return 'invalid email';
                    }
                    if (value.contains(' ')) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
              ),
              SizedBox(width: 80.0),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              SizedBox(width: 80.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'enter a password';
                    } else if (value.length <= 5) {
                      return 'pasword is too short';
                    }
                    if (value.contains(' ')) {
                      return 'invalid password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
              ),
              SizedBox(width: 80.0),
            ],
          ),
          if (_authMode == AuthMode.Register) SizedBox(height: 15.0),
          if (_authMode == AuthMode.Register)
            Row(
              children: <Widget>[
                SizedBox(width: 80.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'confirm password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Register
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'passwords do not match';
                            }
                            return null;
                          }
                        : null,
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                SizedBox(width: 80.0),
              ],
            ),
          SizedBox(height: 70.0),
          if (_isLoading)
            CircularProgressIndicator()
          else
            Row(
              children: <Widget>[
                SizedBox(width: 40.0),
                Expanded(
                  child: BuildButton(_submit,
                      _authMode == AuthMode.Login ? 'sign in' : 'register'),
                ),
                SizedBox(width: 40.0),
              ],
            ),
          SizedBox(height: 100.0),
          Row(
            children: <Widget>[
              SizedBox(width: 125.0),
              Expanded(
                child: BuildButton(
                    _switchAuthMode,
                    _authMode == AuthMode.Login
                        ? 'register'
                        : 'back to sign in'),
              ),
              SizedBox(width: 125.0),
            ],
          ),
        ],
      ),
    );
  }
}
