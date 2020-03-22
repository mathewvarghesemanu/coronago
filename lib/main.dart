import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoronaGo',
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
      home: MyHomePage(title: 'CoronaGo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final player = AudioCache();
  String wintext = '';
  String displaytext = 'Turn your volume up & Tap on the plate';
  int rowcount = 5, colcount = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < colcount; i++)
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          for (int i = 0; i < rowcount; i++)
                            Expanded(
                              child: Image.asset(
                                'android/Asset/corona.png',
                                height: 40,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Text(
              displaytext,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 20, color: Colors.amberAccent),
            ),
            Text(
              wintext,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 20, color: Colors.amberAccent),
            ),
            Container(
              height: 25,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    displaytext = '';
                    rowcount = rowcount - 1;
                    if (rowcount == 0) {
                      colcount = colcount - 1;
                      rowcount = 5;
                      Fluttertoast.showToast(
                          msg: "Go on... You're scaring the corona...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
//                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    if (colcount == 0) {
                      wintext =
                          "Keep up the good work!!!\n You scared the Corona... They fled...";
                      Alert(context: context, title: "Congrats", desc: wintext)
                          .show();
                    }
                  });
                  player.play('clang.wav');
                },
                child: Image.asset(
                  'android/Asset/plate.png',
                  scale: 2,
                  fit: BoxFit.fill,
                  width: 350,
                  height: 350,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
