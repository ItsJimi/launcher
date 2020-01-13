import 'package:flutter/material.dart';
import 'package:launcher/feedcard.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';

class RSSCard extends StatefulWidget {
  dynamic card;

  RSSCard({Key key, this.card}) : super(key: key);

  @override
  _RSSCardState createState() => _RSSCardState();
}

class _RSSCardState extends State<RSSCard> {
  @override
  void initState() {
    super.initState();
  }
  
  Future<List<RssItem>> fetchTopStories() async {
    var response = await http.get(widget.card['options']['url']);

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
      widget.card['title'],
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
              child: ListTile(
                title: Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                subtitle: Text(
                  item.pubDate,
                  style: TextStyle(
                    color: Colors.white54
                  ),
                ),
                trailing: Icon(
                  MdiIcons.arrowRight,
                  color: Colors.white,
                ),
                onTap: () async {
                  try {
                    await launch(item.link);
                  } catch (e) {
                    print(e);
                  }
                }
              )
            )).toList()
          );
        },
      )
    );
  }
}