import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/user_model.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/bluetooth_setup_screen/bluetooth_setup_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import 'scan_result_tile.dart';

class BluetoothSetupScreen extends StatefulWidget {
  final WorkoutMetadata workoutMetadata;

  BluetoothSetupScreen({this.workoutMetadata});

  @override
  _BluetoothSetupScreenState createState() =>
      _BluetoothSetupScreenState(this.workoutMetadata);
}

class _BluetoothSetupScreenState extends State<BluetoothSetupScreen> {
  BluetoothSetupScreenModel bluetoothSetupScreenModel =
      BluetoothSetupScreenModel();

  WorkoutMetadata workoutMetadata;
  bool errorOccurred = false;

  _BluetoothSetupScreenState(WorkoutMetadata workoutMetadata) {
    this.workoutMetadata = workoutMetadata;
  }

  void scanBluetooth() async {
    await bluetoothSetupScreenModel.scanBluetooth();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    scanBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Connecting to bluetooth message.
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Connecting to bluetooth...\n"
                "Please make sure Launchpad Companion App is open...\nor click skip to continue without bluetooth.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.launchpadPrimaryBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // If an error occurred, show an error message to users.
            errorOccurred
                ? Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Error connecting to device, please make sure LCA is open.",
                      style: TextStyle(
                        color: ColorConstants.launchpadRed,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                : Container(),
            // Based on bluetooth scan results...
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              initialData: [],
              builder: (context, snapshot) => Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 10,
                  bottom: SizeConfig.blockSizeVertical * 7,
                ),
                // Build a list of devices that contain LCA in advertisement name.
                child: Column(
                  children: snapshot.data
                      .map((result) => result.device.name.contains('LCA')
                          ? Container(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 3),
                              child: ScanResultTile(
                                  result: result,
                                  onTap: () async {
                                    var isConnected =
                                        await bluetoothSetupScreenModel
                                            .connectBluetoothDevice(
                                      result.device,
                                    );
                                    bluetoothSetupScreenModel.cancelListeners();
                                    if (isConnected) {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return WorkoutVideoScreen(
                                            WorkoutVideoScreenState(
                                              workoutMetadata: workoutMetadata,
                                              currentWorkoutSetIndex: 0,
                                              leaderboards: PlaceholderValues()
                                                  .getleaderboards(),
                                            ),
                                            bluetoothDevice: result.device);
                                      }));
                                    }
                                    setState(() {
                                      this.errorOccurred = true;
                                    });
                                  }),
                            )
                          : Container())
                      .toList(),
                ),
              ),
            ),
            FlatButton(
                color: ColorConstants.launchpadPrimaryBlue,
                child: Text(
                  "Scan for Devices",
                  style: TextStyle(
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  scanBluetooth();
                }),
            FlatButton(
                color: ColorConstants.launchpadPrimaryBlue,
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return WorkoutVideoScreen(
                      WorkoutVideoScreenState(
                          workoutMetadata: workoutMetadata,
                          currentWorkoutSetIndex: 0,
                          leaderboards: PlaceholderValues().getleaderboards(),
                          cumulativeLeaderboards: HashMap()),
                    );
                  }));
                })
          ],
        ),
      ),
    );
  }
}
