import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/models/workout_set_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_model.dart';

class WorkoutVideoScreenModel extends ChangeNotifier {
  // Workout details from home page.
  final WorkoutDetails workoutDetails;
  // All video metadata.
  final WorkoutMetadata workoutMetadata;
  // A list of WorkoutLeaderboardEntries pre-populated with previous users.
  final List<LeaderboardModel> leaderboards;
  // A list of LeaderboardEntries for the user
  final List<LeaderboardEntryModel> userLeaderboardEntries;
  // The bluetooth connected Launchpad Companion App
  final BluetoothDevice bluetoothDevice;
  // The workout set happening currently.
  Timer exerciseTimer;
  int currentWorkoutSetIndex;

  WorkoutVideoScreenModel(
      {this.workoutDetails,
      this.workoutMetadata,
      this.bluetoothDevice,
      this.leaderboards,
      this.userLeaderboardEntries,
      this.currentWorkoutSetIndex = 0,
      this.exerciseTimer});

  WorkoutVideoScreenModel copyWith({
    WorkoutDetails workoutDetails,
    WorkoutMetadata workoutMetadata,
    List<LeaderboardModel> leaderboards,
    BluetoothDevice bluetoothDevice,
    Timer exerciseTimer,
    int currentWorkoutSetIndex,
    List<LeaderboardEntryModel> userLeaderboardEntries,
  }) {
    return WorkoutVideoScreenModel(
      workoutDetails: workoutDetails ?? this.workoutDetails,
      workoutMetadata: workoutMetadata ?? this.workoutMetadata,
      bluetoothDevice: bluetoothDevice ?? this.bluetoothDevice,
      leaderboards: leaderboards ?? this.leaderboards,
      currentWorkoutSetIndex:
          currentWorkoutSetIndex ?? this.currentWorkoutSetIndex,
      exerciseTimer: exerciseTimer ?? this.exerciseTimer,
      userLeaderboardEntries:
          userLeaderboardEntries ?? this.userLeaderboardEntries,
    );
  }

  void changeToNextExercise() {
    currentWorkoutSetIndex++;
  }

  // Get the difference in time from the current exercise to the next
  // queued exercise.
  int _getTimeFromCurrentExerciseToNextExercise() {
    // If this is the first exericse.
    if (currentWorkoutSetIndex == 0) {
      return workoutSets.first.videoTimeStamp;
    }
    // Else if this is the last exercise.
    else if (currentWorkoutSetIndex == workoutSets.length - 1) {
      // End the timer.
      // Or add timer until end of video then end timer.
      return 0;
    }
    // If this is in the middle of the workout,
    // return the time from current exercise until the next
    // exercise.
    return workoutSets[currentWorkoutSetIndex + 1].videoTimeStamp -
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
          milliseconds: _getTimeFromCurrentExerciseToNextExercise(),
        ), () {
      changeToNextExercise();
      if (!isLastSet) {
        _recursiveTimer();
      }
    });
  }

  WorkoutSetModel get currentExercise => workoutSets[currentWorkoutSetIndex];
  bool get isLastSet => currentWorkoutSetIndex == (workoutSets.length - 1);
  int get currentExerciseIndex => currentWorkoutSetIndex;
  List<WorkoutSetModel> get workoutSets => workoutMetadata.workoutSets;
}
