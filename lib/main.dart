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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true),
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
                      Text(
                        app.appName,
                        overflow: TextOverflow.ellipsis
                      )
                    ]
                  )
                )
              );
            },
          );
        },
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
