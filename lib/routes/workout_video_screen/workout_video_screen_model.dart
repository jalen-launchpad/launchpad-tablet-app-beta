import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/models/workout_set_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';

class WorkoutVideoScreenModel extends ChangeNotifier {
  // Workout details from home page.
  final WorkoutDetails workoutDetails;
  // All video metadata.
  final WorkoutMetadata workoutMetadata;
  // All programmed workout sets for this workout.
  final List<WorkoutSetModel> workoutSets;
  // A list of empty WorkoutLeaderboardEntries ready to be populated
  // during the workout.
  final List<LeaderboardEntryModel> leaderboardEntries;
  // The bluetooth connected Launchpad Companion App
  final BluetoothDevice bluetoothDevice;
  // The workout set happening currently.
  Timer exerciseTimer;
  int _currentWorkoutSetIndex;

  WorkoutVideoScreenModel({
    this.workoutDetails,
    this.workoutMetadata,
    this.bluetoothDevice,
    this.leaderboardEntries,
  }) : workoutSets = workoutMetadata.workoutSets {
    _currentWorkoutSetIndex = 0;
  }

  void _changeToNextExercise() {
    _currentWorkoutSetIndex++;
    notifyListeners();
  }

  // Get the difference in time from the current exercise to the next
  // queued exercise.
  int getTimeFromCurrentExerciseToNextExercise() {
    // If this is the first exericse.
    if (_currentWorkoutSetIndex == 0) {
      return workoutSets.first.videoTimeStamp;
    }
    // Else if this is the last exercise.
    else if (_currentWorkoutSetIndex == workoutSets.length - 1) {
      // End the timer.
      // Or add timer until end of video then end timer.
      return 0;
    }
    // If this is in the middle of the workout,
    // return the time from current exercise until the next
    // exercise.
    return workoutSets[_currentWorkoutSetIndex + 1].videoTimeStamp -
        currentExercise.videoTimeStamp;
  }

  // Start a timer that continuously adds on the next timer and
  // updates set informations.
  void startWorkout() {
    _recursiveTimer();
  }

  void _recursiveTimer() {
    exerciseTimer = Timer(
        Duration(
          milliseconds: getTimeFromCurrentExerciseToNextExercise(),
        ), () {
      _changeToNextExercise();
      if (!isLastSet) {
        _recursiveTimer();
      }
    });
  }

  WorkoutSetModel get currentExercise => workoutSets[_currentWorkoutSetIndex];
  bool get isLastSet => _currentWorkoutSetIndex == (workoutSets.length - 1);
  int get currentExerciseIndex => _currentWorkoutSetIndex;
}
