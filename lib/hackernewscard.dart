import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:http/http.dart' as http;

class HackerNewsCard extends StatefulWidget {
  HackerNewsCard({Key key}) : super(key: key);

  @override
  _HackerNewsCardState createState() => _HackerNewsCardState();
}

class _HackerNewsCardState extends State<HackerNewsCard> {
  @override
  void initState() {
    super.initState();
    fetchTopStories();
  }
  
  Future<dynamic> fetchTopStories() async {
    var response = await http.get("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty&orderBy=\"\$key\"&limitToFirst=30");

    var stories = json.decode(response.body);
    stories = stories.map((storyId) async {
      var response = await http.get("https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty");
      return json.decode(response.body);
    }).toList();
    print(stories);
  }

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      "Hacker news",
      Column(
        children: <Widget>[
          Container(
            child: Text(
              'Lorem ipsum',
              style: TextStyle(
                color: Colors.white
              )
            ),
          )
        ],
      )
    );
  }
}