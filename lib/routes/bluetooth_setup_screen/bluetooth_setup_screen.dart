import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/bluetooth_setup_screen/bluetooth_setup_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen.dart';

class BluetoothSetupScreen extends StatefulWidget {
  final WorkoutDetails workoutDetails;

  BluetoothSetupScreen({this.workoutDetails});

  @override
  _BluetoothSetupScreenState createState() =>
      _BluetoothSetupScreenState(this.workoutDetails);
}

class _BluetoothSetupScreenState extends State<BluetoothSetupScreen> {
  BluetoothSetupScreenModel bluetoothSetupScreenModel =
      BluetoothSetupScreenModel();

  WorkoutDetails workoutDetails;
  BluetoothDevice device;

  _BluetoothSetupScreenState(WorkoutDetails workoutDetails) {
    this.workoutDetails = workoutDetails;
  }

  void scanBluetooth() async {
    await bluetoothSetupScreenModel.scanBluetooth();
    await bluetoothSetupScreenModel.connectBluetoothDevice();
    device = (await bluetoothSetupScreenModel.flutterBlue.connectedDevices).first;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    if (bluetoothSetupScreenModel.isNotConnected) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.launchpadPrimaryBlue,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Connecting to bluetooth...\n"
                  "Please make sure Launchpad Companion App is open.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.launchpadPrimaryBlue,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else if (bluetoothSetupScreenModel.isConnectionFound) {
      print("isConnectionFound!");
      print(bluetoothSetupScreenModel.devicesList.first.name);
      // Bluetooth connected without issues. Go straight to workout class.
      Future.microtask(() => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkoutVideoScreen(
                    PlaceholderValues().getWorkoutState(),
                    bluetoothDevice:
                        bluetoothSetupScreenModel.devicesList.first,
                  ))));
      return Container();
    } else {
      // Multiple Connections Found
      print("BluetoothSetupScreenModel result:" +
          bluetoothSetupScreenModel.bluetoothStatus.toString());
      return Container(
        child: Text(
          "Multiple Devices Found!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorConstants.launchpadPrimaryBlue,
            fontSize: 25,
          ),
        ),
      );
    }

    // Bluetooth connected without issues. Go straight to workout class.
    /* Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => WorkoutVideoScreen(
                  PlaceholderValues().getWorkoutState(),
                )));*/
  }
}
