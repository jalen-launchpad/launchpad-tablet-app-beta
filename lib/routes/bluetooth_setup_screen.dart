import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/routes/workout_video_screen.dart';

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
  static const double deviceListHeight = 50;
  static const Text connectButtonTextWidget =
      Text('Connect', style: TextStyle(color: Colors.white));
  static const double containerHeight = 300;
  static const double containerWidth = 500;
  static const double containerBorderRadius = 10;
  static const EdgeInsets containerRowEntryMargin = EdgeInsets.only(right: 30);

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  WorkoutDetails workoutDetails;

  _BluetoothSetupScreenState(WorkoutDetails workoutDetails) {
    this.workoutDetails = workoutDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _buildColumnOfDevices()));
  }

  @override
  initState() {
    super.initState();
    setupBluetooth();
    scanForDevices();
  }

  Future<void> connectToBluetoothDevice(BluetoothDevice device) async {
    print("Connecting to Launchpad Companion App");
    await device.connect(
        timeout: Duration(seconds: connectTimeoutDuration), autoConnect: false);
    print("Finished connecting to Launchpad Companion App");
  }

  void scanForDevices() async {
    this.devicesList = [];
    print("Scanning for bluetooth in progress");
    await this
        .flutterBlue
        .startScan(timeout: Duration(seconds: scanTimeDuration));
    print("Scanning complete");
  }

  void setupBluetooth() {
    this
        .flutterBlue
        .connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        if (device.name.contains(launchpadCompanionAppAbbreviation)) {
          _addDeviceTolist(device);
        }
      }
    });
    this.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.device.name.contains(launchpadCompanionAppAbbreviation)) {
          _addDeviceTolist(result.device);
        }
      }
    });
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!this.devicesList.contains(device)) {
      setState(() {
        this.devicesList.add(device);
      });
    }
  }

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
              onPressed: () async {
                scanForDevices();
              }),
        ],
      ),
    );
  }
}
