import 'dart:async';

import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:redux/redux.dart';

import 'workout_video_screen_reducers.dart';

class WorkoutVideoScreenModel {
  final Store<WorkoutVideoScreenState> store;

  WorkoutVideoScreenModel(this.store);

  // Get the difference in time from the current exercise to the next
  // queued exercise.
  int _getTimeFromCurrentExerciseToNextExercise() {
    // If this is the first exericse.
    if (store.state.currentWorkoutSetIndex == 0) {
      return store.state.workoutSets.first.videoTimeStamp;
    }
    // Else if this is the last exercise.
    else if (store.state.currentWorkoutSetIndex ==
        store.state.workoutSets.length - 1) {
      // End the timer.
      // Or add timer until end of video then end timer.
      return 0;
    }
    // If this is in the middle of the workout,
    // return the time from current exercise until the next
    // exercise.
    return store.state.workoutSets[store.state.currentWorkoutSetIndex + 1]
            .videoTimeStamp -
        store.state.currentExercise.videoTimeStamp;
  }

  // Start a timer that continuously adds on the next timer and
  // updates set informations.
  void startWorkout() {
    _recursiveTimer();
  }

  // Set a timer that changes to the next exercise after the current exercise
  // is done.
  void _recursiveTimer() {
    // Set a timer for the length of the current exercise's video.
    store.state.exerciseTimer = Timer(
        Duration(
          milliseconds: store.state.currentExercise.videoDuration,
        ), () {
      // If it was the last set, don't do anything and return.
      if (store.state.isLastSet) return;
      // If it's not the last set, change to the next exercise.
      changeToNextExercise();
      // Set a new timer for the next exercise.
      _recursiveTimer();
    });
  }

  void changeToNextExercise() {
    store.dispatch(ChangeToNextExerciseAction());
  }
}
