import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_bluetooth_handler.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard.dart';
import 'package:tabletapp/widgets/workout_view/metrics/rep_counter/rep_counter.dart';
import 'package:video_player/video_player.dart';
import 'workout_video_screen_reducers.dart';

class WorkoutVideoScreen extends StatefulWidget {
  final WorkoutVideoScreenState workoutVideoScreenState;
  final BluetoothDevice bluetoothDevice;
  WorkoutVideoScreen(this.workoutVideoScreenState, {this.bluetoothDevice});

  @override
  _WorkoutVideoScreenState createState() =>
      _WorkoutVideoScreenState(this.workoutVideoScreenState,
          bluetoothDevice: this.bluetoothDevice);
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  // The controller for the streaming video.
  VideoPlayerController _controller;
  final WorkoutVideoScreenState workoutVideoScreenState;
  final BluetoothDevice bluetoothDevice;
  WorkoutVideoBluetoothHandler bluetoothHandler;
  WorkoutVideoScreenModel model;
  final Store<WorkoutVideoScreenState> store;

  _WorkoutVideoScreenState(this.workoutVideoScreenState, {this.bluetoothDevice})
      : store = Store(rootReducer, initialState: workoutVideoScreenState) {
    bluetoothHandler = WorkoutVideoBluetoothHandler(bluetoothDevice, store);
    bluetoothHandler.getBluetoothServices();
    model = WorkoutVideoScreenModel(store);
  }

  @override
  void initState() {
    super.initState();

    // Load video.
    _controller = VideoPlayerController.asset('assets/' +
        workoutVideoScreenState.workoutMetadata.workoutDetails.workoutId +
        '.mp4');
    _controller.setLooping(true);

    // Initialize the controller.
    _controller
      ..initialize().then((_) {
        // Play video.
        _controller.play();
        // Start timer on workout to auto-rotate through exercises.
        model.startWorkout();
        setState(() {});
      });
  }

  static const double repCounterLeftPosition = 30;
  static const double repCounterBottomPosition = 75;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<WorkoutVideoScreenState>(
      store: store,
      child: Scaffold(
        body: Stack(children: [
          // Video Player.
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: _controller.value.initialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller))
                        : Container()),
              ],
            ),
          ),
          // Blue gradient effect from left side of screen.
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ColorConstants.launchpadPrimaryBlue,
                        ColorConstants.launchpadPrimaryBlue.withOpacity(0)
                      ], // Blueish to Opaque
                    ),
                  ),
                ),
              ],
            ),
          ),
          StoreConnector<WorkoutVideoScreenState, String>(
            builder: (context, string) => Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 25),
                child: Text(
                  string,
                  style: TextStyle(
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            converter: (store) =>
                store.state.currentExercise.exerciseSetDefinition.exerciseName,
          ),
          // Rep Counter.
          Positioned(
            child: RepCounter(),
            left: repCounterLeftPosition,
            bottom: repCounterBottomPosition,
          ),

          // Leaderboard.
          Positioned(
              child: Leaderboard(
                currentLeaderboard: PlaceholderValues().leaderboard,
              ),
              bottom: repCounterBottomPosition +
                  Leaderboard.workoutLeaderboardHeight +
                  120,
              left: repCounterLeftPosition)
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
