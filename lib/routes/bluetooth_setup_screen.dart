import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen.dart';

import 'workout_video_screen/workout_video_screen_model.dart';

class BluetoothSetupScreen extends StatefulWidget {
  final WorkoutDetails workoutDetails;

  BluetoothSetupScreen({this.workoutDetails});

  @override
  _BluetoothSetupScreenState createState() =>
      _BluetoothSetupScreenState(this.workoutDetails);
}

class _BluetoothSetupScreenState extends State<BluetoothSetupScreen> {
  static const String launchpadCompanionAppAbbreviation = "LCA";
  static const int scanTimeDuration = 5;
  static const int connectTimeoutDuration = 10;

  /* 
  static const double deviceListHeight = 50;
  static const Text connectButtonTextWidget =
      Text('Connect', style: TextStyle(color: Colors.white));
  static const double containerHeight = 300;
  static const double containerWidth = 500;
  static const double containerBorderRadius = 10;
  static const EdgeInsets containerRowEntryMargin = EdgeInsets.only(right: 30);
*/

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  WorkoutDetails workoutDetails;

  _BluetoothSetupScreenState(WorkoutDetails workoutDetails) {
    this.workoutDetails = workoutDetails;
  }

  @override
  Widget build(BuildContext context) {
    if (this.devicesList.length > 1) {
      return Container();
    } else if (this.devicesList.length == 0) {
      // Prompt user to open LCA here.
    } else {
      // Bluetooth connected without issues. Go straight to workout class.
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkoutVideoScreen(WorkoutVideoScreenModel(
                    workoutDetails: this.workoutDetails,
                    bluetoothDevice: this.devicesList.first,
                  ))));
    }
    return Container();
  }

  @override
  initState() {
    super.initState();
    // Populates this.devicesList with all found LCA apps.
    setupBluetooth();
  }

  Future<void> connectToBluetoothDevice(BluetoothDevice device) async {
    print("Connecting to Launchpad Companion App");
    await device.connect(
        timeout: Duration(seconds: connectTimeoutDuration), autoConnect: false);
    print("Finished connecting to Launchpad Companion App");
  }

  void setupBluetooth() async {
    // Get all currently connected LCA apps.
    this
        .flutterBlue
        .connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        if (device.name.contains(launchpadCompanionAppAbbreviation)) {
          print("Device already connected");
          _addDeviceTolist(device);
          return;
        }
      }
    });

    // No LCA app currently found, so prepare for a bluetooth scan.
    // If any LCA apps are found, add them to device list.
    this.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        print(result.device.name);
        if (result.device.name.contains(launchpadCompanionAppAbbreviation)) {
          print("\n\n\n\n\nContains LCA in title");
          if (!this.devicesList.contains(result.device)) {
            print("Device added");
            _addDeviceTolist(result.device);
          }
          // There were no devices found, open LCA.
        }
      }
    });

    // Scan for local BLE devices.
    print("Scanning for bluetooth in progress");
    await this
        .flutterBlue
        .startScan(timeout: Duration(seconds: scanTimeDuration));
    print("Scanning complete");
  }

  void _addDeviceTolist(final BluetoothDevice device) {
    if (!this.devicesList.contains(device)) {
      setState(() {
        this.devicesList.add(device);
      });
    }
  }

/*
  List<Container> _getDevicesAsContainerList() {
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in this.devicesList) {
      containers.add(
        Container(
          height: deviceListHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: containerRowEntryMargin, child: Text(device.name)),
              FlatButton(
                color: Colors.blue,
                child: connectButtonTextWidget,
                onPressed: () async {
                  // print("Waiting for connection");
                  await connectToBluetoothDevice(device);
                  // print("Connection Made");
                  // print(await device.discoverServices());


                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => WorkoutVideoScreen(
                              workoutDetails: this.workoutDetails)));
                },
              ),
            ],
          ),
        ),
      );
    }
    return containers;
  }


  Container _buildColumnOfDevices() {
    List<Container> containers = _getDevicesAsContainerList();
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(containerBorderRadius),
        border:
            Border.all(color: ColorConstants.launchpadPrimaryBlue, width: 4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...containers,
          FlatButton(
              color: Colors.blue,
              child: Text('Search for Companion App Again'),
              onPressed: () async {}),
        ],
      ),
    );
  }*/
}
