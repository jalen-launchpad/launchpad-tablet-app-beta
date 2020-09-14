import 'package:flutter_blue/flutter_blue.dart';
import 'package:redux/redux.dart';
import 'workout_video_screen_reducers.dart';
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

  void getBluetoothServices() async {
    // Discover the services the device offers.
    var bluetoothServices = await device.discoverServices();
    // Get the service we're looking for.
    var service = bluetoothServices.firstWhere((element) =>
        element.uuid.toString() == "16219dce-1e56-4e95-ba3c-766a72f38335");
    // Request notifications from peripheral.
    service.characteristics.first.setNotifyValue(true);
    // When a notification is received -> parse the return.
    service.characteristics.first.value.listen((event) {
      print(event.toList());
      var score = convertByteArrayToInt64(event);
      if (score < 0) return;
      for (int x = 0; x < score; x++) {
        store.dispatch(AddGoodRepAction());
      }
    });
  }
}
