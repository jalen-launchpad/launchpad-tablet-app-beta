import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/exercise_set_model.dart';
import 'package:tabletapp/models/user_model.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/rep_counter.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideoScreen extends StatefulWidget {
  final WorkoutDetails workoutDetails;
  final WorkoutMetadata workoutMetadata;
  WorkoutVideoScreen({this.workoutDetails, this.workoutMetadata});

  @override
  _WorkoutVideoScreenState createState() => _WorkoutVideoScreenState(
      workoutDetails: this.workoutDetails,
      workoutMetadata: this.workoutMetadata);
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  final WorkoutDetails workoutDetails;
  final WorkoutMetadata workoutMetadata;
  VideoPlayerController _controller;

  _WorkoutVideoScreenState({this.workoutDetails, this.workoutMetadata});

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      exerciseLeaderboardEntryModel.addGoodRep();
      exerciseLeaderboardEntryModel.addBadRep();
    });
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/' + workoutDetails.workoutId + '.mp4');
    _controller.setLooping(true);

    _controller
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  final exerciseLeaderboardEntryModel = LeaderboardEntryModel(
      user: UserModel(
          firstName: 'Jalen', lastName: 'Gabbidon', username: 'gabbyyy'),
      exerciseSetDefinition: ExerciseSetModel(
          exerciseName: 'Split Squat', targetReps: 10, isRest: false),
      score: ExerciseScoreModel(
          exerciseSetDefinition: ExerciseSetModel(
              exerciseName: 'Split Squat', targetReps: 10, isRest: false),
          value: 0,
          goodReps: 0,
          badReps: 0));

  static const double repCounterLeftPosition = 30;
  static const double repCounterTopPosition = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<LeaderboardEntryModel>(
              // TODO define initial exerciseleaderboardentrymodel
              create: (context) => exerciseLeaderboardEntryModel),
        ],
        child: Stack(children: [
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
