import 'package:flutter_blue/flutter_blue.dart';
import 'package:redux/redux.dart';
import 'package:tabletapp/constants/bluetooth_uuid.dart';
import 'workout_video_screen_actions.dart';
import 'workout_video_screen_state.dart';

class WorkoutVideoScreenBluetoothHandler {
  final BluetoothDevice device;
  final Store<WorkoutVideoScreenState> store;

  WorkoutVideoScreenBluetoothHandler(this.device, this.store) {
    _getBluetoothServices();
  }

  // This function takes in a List<int> that represents a byte array.
  // Each int in the list will range from 0-255.
  int _convertByteArrayToInt64(List<int> byteArray) {
    // If it was an empty signal, return -1
    if (byteArray.length == 0) return -1;
    // Get the first byte from the list.
    var integer = byteArray[0];
    for (int x = 1; x < byteArray.length; x++) {
      // Left shift the second byte by 8, third byte by 16, so on so on.
      integer += byteArray[x] << (x * 8);
    }
    // Return the integer that was derived from the byte array.
    return integer;
  }

  void _setupBluetoothCharacteristicListeners(
      List<BluetoothCharacteristic> characteristics) async {
    for (int x = 0; x < characteristics.length; x++) {
      await characteristics[x].setNotifyValue(true);
      if (characteristics[x].uuid.toString() ==
          BluetoothUUID.totalScoreUpdate) {
        // When receive a total score update...
        characteristics[x].value.listen((event) {
          if (event.isEmpty) return;
          store.dispatch(AddScoreValueAction(
              newScoreValue: _convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.totalScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
      } else if (characteristics[x].uuid.toString() ==
          BluetoothUUID.xScoreUpdate) {
        // When receive an y score update...
        characteristics[x].value.listen((event) {
          if (event.isEmpty) return;
          // Reflect this in the store.
          store.dispatch(AddScoreValueAction(
              newScoreValue: _convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.xScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
      } else if (characteristics[x].uuid.toString() ==
          BluetoothUUID.yScoreUpdate) {
        // When receive a x score update...
        characteristics[x].value.listen((event) async {
          if (event.isEmpty) return;
          // Reflect this in the store.
          store.dispatch(AddScoreValueAction(
              newScoreValue: _convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.yScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
      }
    }
  }

  void _getBluetoothServices() async {
    // Discover the services the device offers.
    var bluetoothServices = await device.discoverServices();
    // Get the service we're looking for.
    var service = bluetoothServices.firstWhere((element) =>
        element.uuid.toString() == "b293b786-a06e-475c-bc9e-7d61e6b47811");
    // Request notification from peripheral and describe what
    // to do with them.
    _setupBluetoothCharacteristicListeners(service.characteristics);
  }
}
