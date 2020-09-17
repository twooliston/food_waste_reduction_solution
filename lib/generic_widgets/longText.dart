import 'package:flutter/material.dart';

class BuildLongText extends StatelessWidget {
  final String text;
  final double size;

  BuildLongText(this.text, this.size);

  @override
  Widget build(BuildContext context) {
    var setSize = size;
    if (size != null) {
      setSize = 20.0;
    }
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: setSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
