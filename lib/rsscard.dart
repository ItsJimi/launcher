import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RSSCard extends StatefulWidget {
  String url;

  RSSCard({Key key, this.url}) : super(key: key);

  @override
  _RSSCardState createState() => _RSSCardState();
}

class _RSSCardState extends State<RSSCard> {
  @override
  void initState() {
    super.initState();
  }
  
  Future<List<RssItem>> fetchTopStories() async {
    var response = await http.get(widget.url);

    RssFeed feed;
    try {
      feed = RssFeed.parse(response.body);
    } catch (e) {
      return [];
    }
    return feed.items;
  }

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      "RSS",
      FutureBuilder<List<RssItem>>(
        future: fetchTopStories(),
        builder: (BuildContext context, AsyncSnapshot<List<RssItem>> snapshot) {
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Container();
          }

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