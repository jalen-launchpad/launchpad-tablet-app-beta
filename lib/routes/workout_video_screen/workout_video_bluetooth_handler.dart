import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:redux/redux.dart';
import 'package:tabletapp/constants/bluetooth_uuid.dart';
import 'package:tabletapp/constants/colors.dart';
import 'notification_bar/workout_notification.dart';
import 'workout_video_screen_actions.dart';
import 'workout_video_screen_state.dart';

class WorkoutVideoBluetoothHandler {
  final BluetoothDevice device;
  final Store<WorkoutVideoScreenState> store;

  WorkoutVideoBluetoothHandler(this.device, this.store);

  // This function takes in a List<int> that represents a byte array.
  // Each int in the list will range from 0-255.
  int convertByteArrayToInt64(List<int> byteArray) {
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
      characteristics.forEach((element) {
        print(element.uuid.toString());
      });
      // When receive a total score update...
      if (characteristics[x].uuid.toString() ==
          BluetoothUUID.totalScoreUpdate) {
        characteristics[x].value.listen((event) {
        print("total score update was found");
          if (event.isEmpty) return;
          // Reflect this in the store.
          store.dispatch(AddScoreValueAction(
              newScoreValue: convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.totalScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
        // When receive an y score update...
      } else if (characteristics[x].uuid.toString() ==
          BluetoothUUID.xScoreUpdate) {
        characteristics[x].value.listen((event) {
          if (event.isEmpty) return;
        print("x score update was found");
          // Reflect this in the store.
          store.dispatch(AddScoreValueAction(
              newScoreValue: convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.xScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
        // When receive a x score update...
      } else if (characteristics[x].uuid.toString() ==
          BluetoothUUID.yScoreUpdate) {
        characteristics[x].value.listen((event) async {
        print("y score update was found");
          if (event.isEmpty) return;
          // Reflect this in the store.
          store.dispatch(AddScoreValueAction(
              newScoreValue: convertByteArrayToInt64(event),
              scoreTag: BluetoothUUID.yScoreTag));
          store.dispatch(UpdateUserPositionAction());
        });
        // If there is a negative bar update here.
      } else if (characteristics[x].uuid.toString() ==
          BluetoothUUID.negativeCoachingTip) {
        // Add notification bar update here.
        characteristics[x].value.listen((event) {
          if (event.isEmpty) return;
          // If there is currently a notification drop this one.
          if (store.state.showNotification == true) return;

          store.dispatch(UpdateNotificationBarAction(
              workoutNotification: WorkoutNotification(
            Utf8Codec().decode(event),
            ColorConstants.launchpadRed,
          )));
        });
      }
    }
  }

  void getBluetoothServices() async {
    print(device.name);
    // Discover the services the device offers.
    var bluetoothServices = await device.discoverServices();
    // Get the service we're looking for.
    var service = bluetoothServices.firstWhere((element) =>
        element.uuid.toString() == "b293b786-a06e-475c-bc9e-7d61e6b47811");
    // Request notification from peripheral and describe what
    // to do with them.
    print("Setting up bluetooth listeners");
    print(service.characteristics);
    _setupBluetoothCharacteristicListeners(service.characteristics);
  }
}
