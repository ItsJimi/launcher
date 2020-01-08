import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  String title;
  Widget body;

  FeedCard(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.white10,
        borderRadius: new BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: FlatButton(
                    highlightColor: Colors.white12,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )
              ],
            )
          ),
          body
        ]
      )
    );
  }
}