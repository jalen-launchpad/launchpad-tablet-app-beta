import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/colors.dart';
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
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Connecting to bluetooth...\n"
                "Please make sure Launchpad Companion App is open...\nor click skip to continue without bluetooth.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.launchpadPrimaryBlue,
                  fontSize: 25,
                ),
              ),
            ),
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              initialData: [],
              builder: (context, snapshot) => Column(
                children: snapshot.data
                    .map((result) => result.device.name.contains('LCA')
                        ? ScanResultTile(
                            result: result,
                            onTap: () async {
                              var isConnected = await bluetoothSetupScreenModel
                                  .connectBluetoothDevice(
                                result.device,
                              );
                              bluetoothSetupScreenModel.cancelListeners();
                              if (isConnected) {
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (context) {
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
                            })
                        : Container())
                    .toList(),
              ),
            ),
            FlatButton(
                child: Text("Scan for Devices"),
                onPressed: () {
                  scanBluetooth();
                })
          ],
        ),
      ),
    );
  }
}
