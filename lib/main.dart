import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:launcher/addfeedcard.dart';
import 'package:launcher/applist.dart';
import 'package:launcher/feedcard.dart';
import 'package:launcher/rsscard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launcher',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Manjari',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences prefs;
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 1);
    SharedPreferences.getInstance().then((_prefs) {
      setState(() {
        prefs = _prefs;
        cards = getCards();
      });
    });
  }

  List<Widget> getCards() {
    String cards = prefs.getString("feedCards");
    if (cards == null) return [];
    dynamic decodedCards = json.decode(cards);

    List<Widget> widgets = decodedCards.map<Widget>((card) {
      switch (card['type']) {
        case "rss":
          return RSSCard(card: card);
          break;
        default:
          return FeedCard(card['title'], Container());
      }
    }).toList();
    widgets.insert(0, Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: FlatButton(
              highlightColor: Colors.white12,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFeedCardPage()),
                );
              },
            )
          )
        ],
      )
    ));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          controller: _tabController,
          children: [
            Container(
              child: ListView(
                children: cards,
              ),
            ),
            AppList()
          ],
        )
      )
    );
  }
}
