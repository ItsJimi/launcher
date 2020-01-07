import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Application>> getApps(String text) async {
    print(text);
    var apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true);

    return apps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: FutureBuilder(
                future: getApps(searchController.text),
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
                    controller: searchController,
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
      )
    );
  }
}
