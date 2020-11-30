import 'dart:async';

import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

import 'workout_video_screen_actions.dart';

class WorkoutVideoScreenModel {
  final Store<WorkoutVideoScreenState> store;
  final VideoPlayerController controller;
  WorkoutVideoScreenModel(this.store, this.controller);

  // Start a timer that continuously adds on the next timer and
  // updates set informations.
  void startWorkout() {
    startExerciseRotation();
  }

  Future<int> getSecondsElapsed() async {
    return (await controller.position).inSeconds;
  }

  // Set a timer that checks the video controller to see if
  // a change to the next exercise after the current exercise
  // should be done.
  void startExerciseRotation() {
    // Check every second whether the next exercise should rotate in.
    store.state.exerciseTimer = Timer.periodic(
        Duration(
          milliseconds: 500,
        ), (Timer timer) async {
      // If it was the last set, don't do anything and return.
      int secondsElapsed = (await getSecondsElapsed());
      store.dispatch(UpdateSecondsElapsedAction(secondsElapsed));
      if (store.state.classIsOver) {
        print("Class is over");
        return;
      }
      // If the timestamp of the video controller has past the timestamp of the next exercise...
      if (secondsElapsed >= store.state.currentExercise.videoEndTimestamp) {
        // Change state to next exercise.
        changeToNextExercise();
      }
    });
  }

  void changeToNextExercise() {
    store.dispatch(ChangeToNextExerciseAction());
  }
}
