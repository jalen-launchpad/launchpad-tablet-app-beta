import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/progress_bar/progress_bar.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_bluetooth_handler.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';
import 'workout_video_screen_alignment_constants.dart';
import 'leaderboard/interstitial_rest_leaderboard/interstitial_rest_leaderboard.dart';
import 'leaderboard/leaderboard.dart';
import 'post_workout_survey/post_workout_survey.dart';
import 'workout_video_screen_arguments.dart';
import 'workout_video_screen_reducers.dart';

class WorkoutVideoScreen extends StatefulWidget {
  final WorkoutVideoScreenState workoutVideoScreenState;
  final BluetoothDevice bluetoothDevice;
  static const routeName = "WorkoutVideoScreen";
  WorkoutVideoScreen(WorkoutVideoScreenArguments arguments)
      : workoutVideoScreenState = arguments.workoutVideoScreenState,
        bluetoothDevice = arguments.bluetoothDevice;

  @override
  _WorkoutVideoScreenState createState() => _WorkoutVideoScreenState();
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  // The controller for the streaming video.
  VideoPlayerController controller;
  WorkoutVideoScreenBluetoothHandler bluetoothHandler;
  WorkoutVideoScreenModel model;
  Store<WorkoutVideoScreenState> store;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    store = Store(
      rootReducer,
      initialState: widget.workoutVideoScreenState,
    );
    if (widget.bluetoothDevice != null) {
      bluetoothHandler =
          WorkoutVideoScreenBluetoothHandler(widget.bluetoothDevice, store);
    }
    // Load video.
    controller =
        VideoPlayerController.network(store.state.workoutMetadata.streamUri);
    // Initialize the controller.
    controller
      ..initialize().then((_) {
        // Play video.
        controller.play();
        initialized = true;
        model = WorkoutVideoScreenModel();
        // Start timer on workout to auto-rotate through exercises.
        model.startWorkout(store, controller);
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
              body: StoreBuilder<WorkoutVideoScreenState>(
                builder: (context, store) {
                  var classIsOver = store.state.classIsOver;
                  return Stack(children: [
                    // Video Player.
                    _videoPlayer(
                      classIsOver,
                    ),
                    // Blue gradient effect from left side of screen.
                    _blueGradient(),
                    //Progress bar.
                    ProgressBar(),
                    // Exercise Name.
                    _exerciseName(
                      // This check is necessary because classIsOver
                      // is determined by workoutSetIndex >= number of exercises.
                      // Therefore, is classIsOver is true,
                      // currentExercise will throw an index out of bounds error.
                      !classIsOver
                          ? store.state.currentExercise.exerciseSetDefinition
                              .exerciseName
                          : "",
                    ),
                    // Leaderboard or Workout Set Statistics
                    _leaderboard(
                      // This check is necessary because classIsOver
                      // is determined by workoutSetIndex >= number of exercises.
                      // Therefore, is classIsOver is true,
                      // currentExercise will throw an index out of bounds error.
                      !classIsOver ? store.state.currentExercise.isRest : null,
                      classIsOver,
                    ),
                    // Check to see if class is over...
                    // If the class is over.
                    classIsOver
                        ? _endClassAndOverlayPostWorkoutSurvey(store)
                        : Container()
                  ]);
                },
              ),
            ),
          );
  }

  Widget _exerciseName(String exerciseName) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Flexible(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 50,
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 9,
                  left: WorkoutVideoScreenConstants.leftPaddingAlign),
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
    );
  }

  Widget _videoPlayer(bool classIsOver) {
    if (!classIsOver)
      return Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height,
                        child: VideoPlayer(controller))
                    : Container()),
          ],
        ),
      );
    return Container();
  }

  Widget _blueGradient() {
    return Align(
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
    );
  }

  Widget _endClassAndOverlayPostWorkoutSurvey(
      Store<WorkoutVideoScreenState> store) {
    store.state.endClass(
      store.state.exerciseTimer,
      bluetoothDevice:
          store.state.bluetoothDevice ?? store.state.bluetoothDevice,
    );
    // Pause the video controller.
    controller.pause();
    // Display post workout survey
    return Align(
        alignment: Alignment.center,
        child: PostWorkoutSurvey(store.state, this.controller));

    // Otherwise just ignore.
  }

  Widget _leaderboard(bool isRest, bool classIsOver) {
    // Show exercise leaderboard if it is not a rest period.
    if (!classIsOver) {
      if (!isRest) {
        return Positioned(
          child: Leaderboard(),
          bottom: WorkoutVideoScreenConstants.bottomPaddingAlign,
          left: WorkoutVideoScreenConstants.leftPaddingAlign,
        );
      } else {
        Positioned(
          child: InterstitialRestLeaderboard(),
          bottom: WorkoutVideoScreenConstants.bottomPaddingAlign,
          left: WorkoutVideoScreenConstants.leftPaddingAlign,
        );
      }
    }
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    store.teardown();
  }
}
