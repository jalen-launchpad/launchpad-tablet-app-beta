import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/workout_video_screen/progress_bar.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_bluetooth_handler.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';
import 'constants.dart';
import 'leaderboard/leaderboard.dart';
import 'notification_bar/workout_notification.dart';
import 'notification_bar/workout_notification_bar.dart';
import 'rep_counter/standard_rep_counter.dart';
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
  VideoPlayerController controller;
  final WorkoutVideoScreenState workoutVideoScreenState;
  final BluetoothDevice bluetoothDevice;
  WorkoutVideoBluetoothHandler bluetoothHandler;
  WorkoutVideoScreenModel model;
  final Store<WorkoutVideoScreenState> store;
  bool initialized = false;
  _WorkoutVideoScreenState(this.workoutVideoScreenState, {this.bluetoothDevice})
      : store = Store(rootReducer, initialState: workoutVideoScreenState) {
    if (this.bluetoothDevice != null) {
      print("\n\n\n\n\n bluetoothHandler instantiated");
      bluetoothHandler = WorkoutVideoBluetoothHandler(bluetoothDevice, store);
      bluetoothHandler.getBluetoothServices();
    }
  }

  @override
  void initState() {
    super.initState();

    // Load video.
    controller =
        VideoPlayerController.network(store.state.workoutMetadata.streamUri);
    // Initialize the controller.
    controller
      ..initialize().then((_) {
        // Play video.
        controller.play();
        initialized = true;
        model = WorkoutVideoScreenModel(store, controller);
        // Start timer on workout to auto-rotate through exercises.
        model.startWorkout();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return !initialized
        ? Container()
        : StoreProvider<WorkoutVideoScreenState>(
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
                          child: controller.value.initialized
                              ? AspectRatio(
                                  aspectRatio:
                                      MediaQuery.of(context).size.width /
                                          MediaQuery.of(context).size.height,
                                  child: VideoPlayer(controller))
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
                        padding: EdgeInsets.only(right: 10),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(1, 0),
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
                ProgressBar(),
                // Exercise Name.
                StoreConnector<WorkoutVideoScreenState, String>(
                  builder: (context, exerciseName) => Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 50,
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 9,
                                left: WorkoutVideoScreenConstants
                                    .leftPaddingAlign),
                            child: Text(
                              exerciseName,
                              style: TextStyle(
                                color: ColorConstants.launchpadPrimaryWhite,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  converter: (store) => store.state.currentExercise.isRest
                      ? "Rest"
                      : store.state.currentExercise.exerciseSetDefinition
                          .exerciseName,
                ),
                // Rep Counter.
                Positioned(
                  child: StandardRepCounter(),
                  left: WorkoutVideoScreenConstants.leftPaddingAlign,
                  bottom: WorkoutVideoScreenConstants.bottomPaddingAlign,
                ),

                // Leaderboard.
                Positioned(
                  child: Leaderboard(
                    currentLeaderboard: PlaceholderValues().leaderboard,
                  ),
                  bottom: WorkoutVideoScreenConstants.bottomPaddingAlign +
                      Leaderboard.workoutLeaderboardHeight +
                      SizeConfig.blockSizeVertical * 18,
                  left: WorkoutVideoScreenConstants.leftPaddingAlign,
                ),
                // Notification Bar - NEEDS SIZECONFIG UPDATES
                // TODO(jalen): Size Config Updates here.
                StoreConnector<WorkoutVideoScreenState, WorkoutNotification>(
                  builder: (context, workoutNotification) =>
                      store.state.showNotification == false
                          ? Container(
                              height: 0,
                              width: 0,
                            )
                          : Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                child: WorkoutNotificationBar(
                                    workoutNotification, store),
                                padding: EdgeInsets.only(bottom: 85, right: 15),
                              ),
                            ),
                  converter: (store) => store.state.workoutNotification,
                ),
              ]),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
