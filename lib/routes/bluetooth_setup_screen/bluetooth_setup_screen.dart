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
import 'package:tabletapp/routes/bluetooth_setup_screen/bluetooth_setup_screen_arguments.dart';
import 'package:tabletapp/routes/bluetooth_setup_screen/bluetooth_setup_screen_model.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';
import 'package:tabletapp/routes/workout_video_screen/post_workout_survey/post_workout_survey_response_box_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_arguments.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import 'scan_result_tile.dart';

class BluetoothSetupScreen extends StatefulWidget {
  final WorkoutMetadata workoutMetadata;
  final HomePageScreenState homePageScreenState;
  static const routeName = "BluetoothSetupScreen";

  BluetoothSetupScreen(BluetoothSetupScreenArguments arguments)
      : workoutMetadata = arguments.workoutMetadata,
        homePageScreenState = arguments.homePageScreenState;

  @override
  _BluetoothSetupScreenState createState() => _BluetoothSetupScreenState(
      this.workoutMetadata, this.homePageScreenState);
}

class _BluetoothSetupScreenState extends State<BluetoothSetupScreen> {
  BluetoothSetupScreenModel bluetoothSetupScreenModel =
      BluetoothSetupScreenModel();
  final HomePageScreenState homePageScreenState;

  final WorkoutMetadata workoutMetadata;
  bool errorOccurred = false;

  _BluetoothSetupScreenState(this.workoutMetadata, this.homePageScreenState);

  void scanBluetooth() async {
    await bluetoothSetupScreenModel.scanBluetooth();
  }

  @override
  void initState() {
    super.initState();
    scanBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 4,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  HomePageScreen.routeName,
                  arguments: homePageScreenState,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      SizeConfig.blockSizeHorizontal * 0.25),
                  color: ColorConstants.launchpadRed,
                ),
                width: SizeConfig.blockSizeHorizontal * 10,
                height: SizeConfig.blockSizeVertical * 6,
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal,
                      color: ColorConstants.launchpadPrimaryWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
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
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
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
                            fontSize: SizeConfig.blockSizeHorizontal,
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
                                        bluetoothSetupScreenModel
                                            .cancelListeners();
                                        if (isConnected) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  WorkoutVideoScreen.routeName,
                                                  arguments:
                                                      WorkoutVideoScreenArguments(
                                                          WorkoutVideoScreenState(
                                                            workoutMetadata:
                                                                workoutMetadata,
                                                            currentWorkoutSetIndex:
                                                                0,
                                                            leaderboards:
                                                                PlaceholderValues()
                                                                    .getleaderboards(),
                                                            cumulativeLeaderboards:
                                                                HashMap(),
                                                            postWorkoutSurveyResponseBoxModel:
                                                                PostWorkoutSurveyResponseBoxModel
                                                                    .initialize(),
                                                            user: UserModel(
                                                              username: "jalen",
                                                            ),
                                                            bluetoothDevice:
                                                                result.device,
                                                          ),
                                                          bluetoothDevice:
                                                              result.device));
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
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 6,
                      child: Center(
                        child: Text(
                          "Scan for Devices",
                          style: TextStyle(
                              color: ColorConstants.launchpadPrimaryWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal),
                        ),
                      ),
                    ),
                    onPressed: () {
                      scanBluetooth();
                    }),
                Container(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                FlatButton(
                    color: ColorConstants.launchpadPrimaryBlue,
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 6,
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: ColorConstants.launchpadPrimaryWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          WorkoutVideoScreen.routeName,
                          arguments: WorkoutVideoScreenArguments(
                            WorkoutVideoScreenState(
                                workoutMetadata: workoutMetadata,
                                currentWorkoutSetIndex: 0,
                                leaderboards:
                                    PlaceholderValues().getleaderboards(),
                                cumulativeLeaderboards: WorkoutVideoScreenState
                                    .initializeCuumulativeLeaderboard(
                                  PlaceholderValues().getleaderboards(),
                                ),
                                postWorkoutSurveyResponseBoxModel:
                                    PostWorkoutSurveyResponseBoxModel
                                        .initialize(),
                                user: UserModel(
                                  username: "jalen",
                                ),
                                bluetoothDevice: null),
                          ));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
