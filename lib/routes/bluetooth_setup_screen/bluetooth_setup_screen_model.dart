import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/bluetooth_uuid.dart';

class BluetoothSetupScreenModel {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  static const String launchpadCompanionAppAbbreviation = "LCA";
  static const int scanTimeDuration = 3;
  BluetoothDevice connectedDevice;
  List<BluetoothDevice> _devicesList = [];
  StreamSubscription<List<ScanResult>> scanResultListener;
  BluetoothConnectionStatusEnum _bluetoothStatus =
      BluetoothConnectionStatusEnum.notConnected;

  FlutterBlue get flutterBlue => _flutterBlue;
  List<BluetoothDevice> get devicesList => _devicesList;
  BluetoothConnectionStatusEnum get bluetoothStatus => _bluetoothStatus;
  bool get isConnected =>
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

  void cancelListeners() {
    scanResultListener.cancel();
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

  Future<bool> connectBluetoothDevice(BluetoothDevice device) async {
    try {
      // Canel the scan if not already cancelled by now.
      this.scanResultListener.cancel();
      // Get the device we're going to connect to.
      // Connect to device.
      if (await device.state.first == BluetoothDeviceState.connected) {
        await device.disconnect();
      }
      await device.connect(
        timeout: Duration(seconds: 5),
        // This takes up to 30 seconds or more when set true.
        autoConnect: false,
      );
      var services = await device.discoverServices();
      print("\n\n\n\n\n");
      print("service count: " + services.length.toString());
      print(services.indexWhere(
          (element) => element.uuid.toString() == BluetoothUUID.service));
      if (services.indexWhere(
              (element) => element.uuid.toString() == BluetoothUUID.service) ==
          -1) {
        await device.disconnect();
        return false;
      }
      //
      _bluetoothStatus = BluetoothConnectionStatusEnum.isConnected;
    } catch (e) {
      throw e;
    }
    return true;
  }

  // Empty _devicesList and disconnect to any connected Companion Apps.
  Future<void> clearBluetooth() async {
    print("Device already connected, disconnecting.");
    for (BluetoothDevice device in await this.flutterBlue.connectedDevices) {
      print("Device connected");
      await device.disconnect();
    }
    this._devicesList = [];
    await this.flutterBlue.stopScan();
  }

  Future<void> scanBluetooth() async {
    // Clear all connected LCA.
    await clearBluetooth();
    print("connected devices length: " +
        (await this.flutterBlue.connectedDevices).length.toString());
    print("this._devicesList.length: " + this._devicesList.length.toString());
    // Scan for local BLE devices.
    print("Scanning for bluetooth in progress");
    await this.flutterBlue.startScan(timeout: Duration(seconds: 3));
  }
}

enum BluetoothConnectionStatusEnum {
  isConnected,
  notConnected,
  multipleConnectionsFound,
}
