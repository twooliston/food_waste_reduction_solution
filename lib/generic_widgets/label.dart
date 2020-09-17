import 'package:flutter/material.dart';

class BuildLabel extends StatelessWidget {
  final String text;

  BuildLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
