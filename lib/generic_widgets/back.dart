import 'package:flutter/material.dart';

class BuildBackArrow extends StatelessWidget {
  final BuildContext ctx;

  BuildBackArrow(this.ctx);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: const Icon(
            Icons.arrow_back,
            size: 50.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}