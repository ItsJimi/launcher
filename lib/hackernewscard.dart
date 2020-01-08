import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class HackerNewsCard extends StatefulWidget {
  HackerNewsCard({Key key}) : super(key: key);

  @override
  _HackerNewsCardState createState() => _HackerNewsCardState();
}

class _HackerNewsCardState extends State<HackerNewsCard> {
  @override
  void initState() {
    super.initState();
  }
  
  Future<List<RssItem>> fetchTopStories() async {
    var response = await http.get("https://news.ycombinator.com/rss");

    var feed = new RssFeed.parse(response.body);
    return feed.items;
  }

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      "Hacker news",
      FutureBuilder<List<RssItem>>(
        future: fetchTopStories(),
        builder: (BuildContext context, AsyncSnapshot<List<RssItem>> snapshot) {
          return Column(
            children: snapshot.data.map((item) => Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                item.title,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )).toList()
          );
        },
      )
    );
  }
}