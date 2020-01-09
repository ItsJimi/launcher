import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRSSCardPage extends StatefulWidget {
  AddRSSCardPage({Key key}) : super(key: key);

  @override
  _AddRSSCardPageState createState() => _AddRSSCardPageState();
}

class _AddRSSCardPageState extends State<AddRSSCardPage> {
  final cardNameController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add RSS card"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Material(
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: cardNameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.white70
                    ),
                    hintText: 'Card name',
                    border: InputBorder.none
                  ),
                  style: TextStyle(
                    color: Colors.white
                  )
                )
              ),
              elevation: 0,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Material(
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.white70
                    ),
                    hintText: 'RSS feed url',
                    border: InputBorder.none
                  ),
                  style: TextStyle(
                    color: Colors.white
                  )
                )
              ),
              elevation: 0,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )
          ),
          FlatButton(
            textColor: Colors.white,
            child: Text(
              "Add"
            ),
            onPressed: () async {
              SharedPreferences prefs;
              
              try {
                prefs = await SharedPreferences.getInstance();
              } catch (e) {
                print(e);
                return;
              }

              String cards = prefs.getString("feedCards");
              dynamic decodedCards = json.decode(cards);
              if (cards == null) decodedCards = [];

              decodedCards.add({
                "type": "rss",
                "title": cardNameController.text,
                "options": {
                  "url": urlController.text
                }
              });

              try {
                await prefs.setString("feedCards", json.encode(decodedCards));
              } catch (e) {
                print(e);
                return;
              }

              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}
