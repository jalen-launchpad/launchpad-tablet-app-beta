import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/models/workout_set_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_model.dart';
import 'package:tabletapp/widgets/workout_view/notification_bar/workout_notification.dart';

class WorkoutVideoScreenState extends ChangeNotifier {
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

  WorkoutVideoScreenState(
      {this.workoutMetadata,
      this.bluetoothDevice,
      this.leaderboards,
      this.currentWorkoutSetIndex = 0,
      this.exerciseTimer,
      this.showNotification,
      this.workoutNotification});

  WorkoutVideoScreenState copyWith({
    WorkoutDetails workoutDetails,
    WorkoutMetadata workoutMetadata,
    List<LeaderboardModel> leaderboards,
    BluetoothDevice bluetoothDevice,
    Timer exerciseTimer,
    int currentWorkoutSetIndex,
    List<LeaderboardEntryModel> userLeaderboardEntries,
    bool showNotification,
    WorkoutNotification workoutNotification,
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
    );
  }

  void changeToNextExercise() {
    currentWorkoutSetIndex++;
  }

  WorkoutSetModel get currentExercise => workoutSets[currentWorkoutSetIndex];
  bool get isLastSet => currentWorkoutSetIndex == (workoutSets.length - 1);
  int get currentExerciseIndex => currentWorkoutSetIndex;
  List<WorkoutSetModel> get workoutSets => workoutMetadata.workoutSets;
}
