import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
          MdiIcons.fromString(icon),
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}