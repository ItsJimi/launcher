import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:launcher/iotbutton.dart';

class IOTCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeedCard(
      "Home",
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          IOTButton("lightbulb"),
          IOTButton("window-shutter-open"),
          IOTButton("window-shutter"),
        ]
      )
    );
  }
}