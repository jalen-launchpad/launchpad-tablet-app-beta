import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/models/workout_set_model.dart';

import 'leaderboard/leaderboard_entry_model.dart';
import 'leaderboard/leaderboard_model.dart';
import 'notification_bar/workout_notification.dart';

class WorkoutVideoScreenState {
  // All video metadata.
  final WorkoutMetadata workoutMetadata;
  // A list of WorkoutLeaderboardEntries pre-populated with previous users.
  final List<LeaderboardModel> leaderboards;
  // The bluetooth connected Launchpad Companion App
  final BluetoothDevice bluetoothDevice;
  final bool showNotification;
  // The workout notification currently shown on screen.
  final WorkoutNotification workoutNotification;
  Timer exerciseTimer;
  int currentWorkoutSetIndex;
  final int secondsElapsed;

  WorkoutVideoScreenState(
      {this.workoutMetadata,
      this.bluetoothDevice,
      this.leaderboards,
      this.currentWorkoutSetIndex = 0,
      this.exerciseTimer,
      this.showNotification = false,
      this.workoutNotification,
      this.secondsElapsed = 0});

  static WorkoutVideoScreenState initializeWorkout(
      WorkoutMetadata workoutMetadata,
      {BluetoothDevice bluetoothDevice}) {
    return WorkoutVideoScreenState(
      workoutMetadata: workoutMetadata,
      // Retrieve leaderboards!!
      // TODO(jalen): retrieve leaderboards
      bluetoothDevice: bluetoothDevice != null ? bluetoothDevice : null,
    );
  }

  WorkoutVideoScreenState copyWith({
    WorkoutDetails workoutDetails,
    WorkoutMetadata workoutMetadata,
    List<LeaderboardModel> leaderboards,
    BluetoothDevice bluetoothDevice,
    Timer exerciseTimer,
    int currentWorkoutSetIndex,
    bool showNotification,
    WorkoutNotification workoutNotification,
    int secondsElapsed,
  }) {
    return WorkoutVideoScreenState(
        workoutMetadata: workoutMetadata ?? this.workoutMetadata,
        bluetoothDevice: bluetoothDevice ?? this.bluetoothDevice,
        leaderboards: leaderboards ?? this.leaderboards,
        currentWorkoutSetIndex:
            currentWorkoutSetIndex ?? this.currentWorkoutSetIndex,
        exerciseTimer: exerciseTimer ?? this.exerciseTimer,
        workoutNotification: workoutNotification ?? this.workoutNotification,
        showNotification: showNotification ?? this.showNotification,
        secondsElapsed: secondsElapsed ?? this.secondsElapsed);
  }

  void changeToNextExercise() {
    currentWorkoutSetIndex++;
  }

  WorkoutSetModel get currentExercise => workoutSets[currentWorkoutSetIndex];
  WorkoutSetModel get previousExercise =>
      workoutSets[currentWorkoutSetIndex > 0 ? currentWorkoutSetIndex - 1 : 0];
  WorkoutSetModel get nextExercise =>
      !isLastSet ? workoutSets[currentWorkoutSetIndex + 1] : null;
  bool get isLastSet => currentWorkoutSetIndex == (workoutSets.length - 1);
  int get currentExerciseIndex => currentWorkoutSetIndex;
  int get currentUserScore =>
      leaderboards[currentExerciseIndex].userEntry.score.value;
  set currentUserScore(int score) {
    leaderboards[currentExerciseIndex].userEntry.score.value = score;
  }

  LeaderboardEntryModel get previousUserLeaderboardEntry =>
      leaderboards[currentWorkoutSetIndex > 0 ? currentWorkoutSetIndex - 1 : 0]
          .userEntry;
  LeaderboardModel get previousLeaderboard =>
      leaderboards[currentWorkoutSetIndex > 0 ? currentWorkoutSetIndex - 1 : 0];

  List<WorkoutSetModel> get workoutSets => workoutMetadata.workoutSets;
}
