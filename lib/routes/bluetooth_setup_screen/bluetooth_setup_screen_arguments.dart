import 'package:flutter/foundation.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';

class BluetoothSetupScreenArguments {
  final WorkoutMetadata workoutMetadata;
  final HomePageScreenState homePageScreenState;
  BluetoothSetupScreenArguments(
      {@required this.workoutMetadata, @required this.homePageScreenState});
}
