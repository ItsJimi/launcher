import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppList extends StatefulWidget {
  AppList({Key key}) : super(key: key);

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  String searchText = "";
  List<Application> apps = [];

  Future<List<Application>> getApps() async {
    if (apps.length == 0) {
      apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true, includeSystemApps: true);
    }

    var filteredApps = apps.where((app) => app.appName.toLowerCase().contains(searchText.toLowerCase())).toList();
  
    return filteredApps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: FutureBuilder(
              future: getApps(),
              builder: (context, projectSnap) {
                if (projectSnap.data == null) {
                  return Container();
                }

                return GridView.builder(
                  padding: EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  itemCount: projectSnap.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var app = projectSnap.data[index];
                    return GestureDetector(
                      onTap: () {
                        DeviceApps.openApp(app.packageName);
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              child: Image.memory(app.icon)
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                app.appName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                ),
                              )
                            )
                          ]
                        )
                      )
                    );
                  },
                );
              },
            )
          ),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10),
            child: Material(
              color: Colors.white10,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 1),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.white70
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none
                  ),
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              elevation: 0,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          )
        ],
      )
    );
  }
}