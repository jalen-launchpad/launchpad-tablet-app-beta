import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/progress_bar.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_bluetooth_handler.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';
import 'constants.dart';
import 'leaderboard/interstitial_rest_leaderboard/interstitial_rest_leaderboard.dart';
import 'leaderboard/leaderboard.dart';
import 'notification_bar/workout_notification.dart';
import 'notification_bar/workout_notification_bar.dart';
import 'post_workout_survey/post_workout_survey.dart';
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
    this.workoutVideoScreenState.initializeCuumulativeLeaderboard();
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
                !store.state.classIsOver
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                child: controller.value.initialized
                                    ? AspectRatio(
                                        aspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            MediaQuery.of(context).size.height,
                                        child: VideoPlayer(controller))
                                    : Container()),
                          ],
                        ),
                      )
                    : Container(),
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
                                fontWeight: FontWeight.bold,
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
                // Leaderboard or Workout Set Statistics
                StoreBuilder<WorkoutVideoScreenState>(
                    builder: (context, store) {
                  if (!store.state.classIsOver) {
                    return !store.state.currentExercise.isRest
                        ?
                        // Show exercise leaderboard if it is not a rest period.
                        Positioned(
                            child: Leaderboard(),
                            bottom:
                                WorkoutVideoScreenConstants.bottomPaddingAlign,
                            left: WorkoutVideoScreenConstants.leftPaddingAlign,
                          )
                        : Positioned(
                            child: InterstitialRestLeaderboard(),
                            bottom:
                                WorkoutVideoScreenConstants.bottomPaddingAlign,
                            left: WorkoutVideoScreenConstants.leftPaddingAlign,
                          );
                  } else {
                    return Container();
                  }
                }),
                // Check to see if class is over...
                StoreBuilder<WorkoutVideoScreenState>(
                    builder: (context, store) {
                  // If the class is over.
                  if (store.state.classIsOver) {
                    // Cancel the exercise timer
                    store.state.exerciseTimer.cancel();
                    // Disconnect the bluetooth device
                    if (store.state.bluetoothDevice != null)
                      store.state.bluetoothDevice.disconnect();
                    // Dispose of the video controller resources
                    controller.dispose();
                    // Display post workout survey
                    return Align(
                        alignment: Alignment.center,
                        child: PostWorkoutSurvey(this.store.state));
                  }
                  // Otherwise just ignore.
                  return Container();
                }),
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
