import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

class WorkoutVideoScreenArguments {
  final BluetoothDevice bluetoothDevice;
  final WorkoutVideoScreenState workoutVideoScreenState;

  WorkoutVideoScreenArguments(this.workoutVideoScreenState,
      {this.bluetoothDevice});
}
