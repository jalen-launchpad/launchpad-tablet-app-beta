import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothSetupScreenModel {
  static const String launchpadCompanionAppAbbreviation = "LCA";
  static const int scanTimeDuration = 3;

  BluetoothDevice connectedDevice;

  List<BluetoothDevice> _devicesList = [];
  List<BluetoothDevice> get devicesList => _devicesList;

  StreamSubscription<List<ScanResult>> scanResultListener;

  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  FlutterBlue get flutterBlue => _flutterBlue;

  BluetoothConnectionStatusEnum _bluetoothStatus =
      BluetoothConnectionStatusEnum.notConnected;
  BluetoothConnectionStatusEnum get bluetoothStatus => _bluetoothStatus;
  bool get isConnectionFound =>
      _bluetoothStatus == BluetoothConnectionStatusEnum.isConnected;
  bool get isMultipleConnectionsFound =>
      _bluetoothStatus ==
      BluetoothConnectionStatusEnum.multipleConnectionsFound;
  bool get isNotConnected =>
      _bluetoothStatus == BluetoothConnectionStatusEnum.notConnected;

  // Set up bluetooth on instantiation.
  BluetoothSetupScreenModel() {
    _setupBluetooth();
  }
// This is the bluetooth functionality that is called when connected.
  void _setupBluetooth() {
    // No LCA app currently found, so prepare for a bluetooth scan.
    this.scanResultListener =
        this.flutterBlue.scanResults.listen((List<ScanResult> results) async {
      // If any LCA apps are found, add them to device list.
      _filterScanResults(results);
      // Set the bluetooth connection status and
      // connect to device if applicable.
    });
  }

  // Filter any devices that arent from the LCA and add the LCA to devicesList
  void _filterScanResults(List<ScanResult> results) {
    for (ScanResult result in results) {
      // If the device contains the LCA abbreviation and has not already
      // been detected during the scan...
      if (result.device.name.contains(launchpadCompanionAppAbbreviation) &&
          !this._devicesList.contains(result.device)) {
        this._devicesList.add(result.device);
      }
    }
  }

  void _setBluetoothStatus() {
    // If there's too many LCA found.
    if (this._devicesList.length > 1) {
      _bluetoothStatus = BluetoothConnectionStatusEnum.multipleConnectionsFound;
    } else if (this._devicesList.length == 0) {
      // If no LCA was found.
      _bluetoothStatus = BluetoothConnectionStatusEnum.notConnected;
    } else {
      _bluetoothStatus = BluetoothConnectionStatusEnum.isConnected;
      // If only one LCA was found..
    }
  }

  Future<void> connectBluetoothDevice() async {
    try {
      // Canel the scan if not already cancelled by now.
      this.scanResultListener.cancel();
      // Get the device we're going to connect to.
      connectedDevice = this._devicesList.first;
      // Connect to device.
      await connectedDevice.connect(
        timeout: Duration(seconds: 15),
        // This takes up to 30 seconds or more when set true.
        // 
        autoConnect: false,
      );
      //
      _bluetoothStatus = BluetoothConnectionStatusEnum.isConnected;
    } catch (e) {
      throw e;
    }
    return;
  }

  // Empty _devicesList and disconnect to any connected Companion Apps.
  Future<void> clearBluetooth() async {
    print("Device already connected, disconnecting.");
    for (BluetoothDevice device in await this.flutterBlue.connectedDevices) {
      print("Device connected");
      await device.disconnect();
    }
    this._devicesList = [];
  }

  Future<void> scanBluetooth() async {
    // Clear all connected LCA.
    await clearBluetooth();
    // Scan for local BLE devices.
    print("Scanning for bluetooth in progress");
    await this.flutterBlue.startScan(timeout: Duration(seconds: 3));
    _setBluetoothStatus();
    print("Scanning complete with status: " + _bluetoothStatus.toString());
  }
}

enum BluetoothConnectionStatusEnum {
  isConnected,
  notConnected,
  multipleConnectionsFound,
}
