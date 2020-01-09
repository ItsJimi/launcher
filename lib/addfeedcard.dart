import 'package:flutter/material.dart';
import 'package:launcher/addrsscard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddFeedCardPage extends StatefulWidget {
  AddFeedCardPage({Key key}) : super(key: key);

  @override
  _AddFeedCardPageState createState() => _AddFeedCardPageState();
}

class _AddFeedCardPageState extends State<AddFeedCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add feed card"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              "RSS",
              style: TextStyle(
                color: Colors.white
              )
            ),
            subtitle: Text(
              "Create a card with RSS flux",
              style: TextStyle(
                color: Colors.white54
              )
            ),
            trailing: Icon(
              MdiIcons.arrowRight,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRSSCardPage()),
              );
            },
          )
        ],
      )
    );
  }
}
