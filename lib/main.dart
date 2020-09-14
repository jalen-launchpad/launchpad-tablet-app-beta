import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/exercise_set_model.dart';
import 'package:tabletapp/models/user_model.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/bluetooth_setup_screen/bluetooth_setup_screen.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';

import 'enums/mods_enum.dart';
import 'models/workout_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launchpad Demo',
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
        fontFamily: 'Jost',
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Center(child: BluetoothSetupScreen());
  }
}
