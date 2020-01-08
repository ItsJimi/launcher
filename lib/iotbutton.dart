import 'package:flutter/material.dart';

class IOTButton extends StatelessWidget {
  String icon;

  IOTButton(this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white12,
          borderRadius: new BorderRadius.all(Radius.circular(100))
        ),
        child: Icon(
          Icons.lightbulb_outline,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}