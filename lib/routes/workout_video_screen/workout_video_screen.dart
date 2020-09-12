import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/rep_counter/rep_counter.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideoScreen extends StatefulWidget {
  final WorkoutVideoScreenModel workoutVideoScreenModel;
  WorkoutVideoScreen(this.workoutVideoScreenModel);

  @override
  _WorkoutVideoScreenState createState() =>
      _WorkoutVideoScreenState(this.workoutVideoScreenModel);
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  // The controller for the streaming video.
  VideoPlayerController _controller;
  final WorkoutVideoScreenModel workoutVideoScreenModel;

  _WorkoutVideoScreenState(this.workoutVideoScreenModel);

  @override
  void initState() {
    super.initState();

    // Load video.
    _controller = VideoPlayerController.asset(
        'assets/' + workoutVideoScreenModel.workoutDetails.workoutId + '.mp4');
    _controller.setLooping(true);

    // Play video.
    _controller
      ..initialize().then((_) {
        _controller.play();
        // Start timer on workout with corrections.
        workoutVideoScreenModel.startWorkout();
        setState(() {});
      });
  }

  static const double repCounterLeftPosition = 30;
  static const double repCounterTopPosition = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<LeaderboardEntryModel>(
              create: (context) => workoutVideoScreenModel.leaderboardEntries[workoutVideoScreenModel.currentExerciseIndex]),
          ChangeNotifierProvider<WorkoutVideoScreenModel>(
            create: (context) => workoutVideoScreenModel,
          )
        ],
        child: Stack(children: [
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
          // Rep Counter.
          Positioned(
            child: RepCounter(),
            left: repCounterLeftPosition,
            top: repCounterTopPosition,
          ),
          /*
          Positioned(
            child: WorkoutMenuOptionsButtons(
              videoPlayerController: _controller,
            ),
            bottom: workoutMenuOptionsButtonBottomPosition,
            right: workoutMenuOptionsButtonRightPosition,
          ),
          */

          // Leaderboard.
          Positioned(
              child: Leaderboard(
                currentLeaderboard: PlaceholderValues().leaderboard,
              ),
              top: repCounterTopPosition +
                  Leaderboard.workoutLeaderboardHeight +
                  75,
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
