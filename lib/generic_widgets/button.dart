import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final Function function;
  final String text;

  BuildButton(this.function, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 75,
      child: RaisedButton(
        elevation: 0.0,
        color: Theme.of(context).accentColor,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: function,
      ),
    );
  }
}
