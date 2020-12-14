import 'dart:async';

import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

import 'workout_video_screen_actions.dart';

class WorkoutVideoScreenModel {
  // Set a timer that checks the video controller to see if
  // a change to the next exercise after the current exercise
  // should be done.
  void startWorkout(
      Store<WorkoutVideoScreenState> store, VideoPlayerController controller) {
    // Check every second whether the next exercise should rotate in.
    store.state.exerciseTimer = Timer.periodic(
        Duration(
          milliseconds: 500,
        ), (Timer timer) async {
      // If it was the last set, don't do anything and return.
      int secondsElapsed = (await controller.position).inSeconds;
      print(secondsElapsed);
      store.dispatch(UpdateSecondsElapsedAction(secondsElapsed));
      if (store.state.classIsOver) {
        return;
      }
      print(secondsElapsed >= store.state.currentExercise.videoEndTimestamp);
      print(
          "videoEndTimestamp: ${store.state.currentExercise.videoEndTimestamp}");
      // If the timestamp of the video controller has past the timestamp of the next exercise...
      if (secondsElapsed >= store.state.currentExercise.videoEndTimestamp) {
        // Change state to next exercise.
        store.dispatch(ChangeToNextExerciseAction());
      }
    });
  }
}
