import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/user_model.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/models/workout_set_model.dart';
import 'leaderboard/leaderboard_entry_model.dart';
import 'leaderboard/leaderboard_model.dart';
import 'post_workout_survey/post_workout_survey_response_box_model.dart';

class WorkoutVideoScreenState {
  // All video metadata.
  final WorkoutMetadata workoutMetadata;
  // A list of WorkoutLeaderboardEntries pre-populated with previous users.
  final List<LeaderboardModel> leaderboards;
  final HashMap<UserModel, int> cumulativeLeaderboards;
  // The bluetooth connected Launchpad Companion App
  final BluetoothDevice bluetoothDevice;
  Timer exerciseTimer;
  int currentWorkoutSetIndex;
  final int secondsElapsed;
  final PostWorkoutSurveyResponseBoxModel postWorkoutSurveyResponseBoxModel;
  final UserModel user;

  LeaderboardModel get currentLeaderboard =>
      leaderboards[currentWorkoutSetIndex];

  List<WorkoutSetModel> get workoutSets => workoutMetadata.workoutSets;

  WorkoutSetModel get currentExercise => workoutSets[currentWorkoutSetIndex];

  WorkoutSetModel get previousExercise =>
      workoutSets[currentWorkoutSetIndex > 0 ? currentWorkoutSetIndex - 1 : 0];

  WorkoutSetModel get nextExercise =>
      !isLastSet ? workoutSets[currentWorkoutSetIndex + 1] : null;

  bool get isLastSet => currentWorkoutSetIndex == (workoutSets.length - 1);

  bool get classIsOver => currentWorkoutSetIndex >= workoutSets.length;

  int get currentUserScore =>
      leaderboards[currentWorkoutSetIndex].userEntry.score.value;

  set currentUserScore(int score) {
    leaderboards[currentWorkoutSetIndex].userEntry.score.value = score;
  }

  WorkoutVideoScreenState({
    @required this.workoutMetadata,
    @required this.bluetoothDevice,
    @required this.leaderboards,
    @required this.cumulativeLeaderboards,
    @required this.postWorkoutSurveyResponseBoxModel,
    @required this.user,
    this.currentWorkoutSetIndex = 0,
    this.exerciseTimer,
    this.secondsElapsed = 0,
  });

  WorkoutVideoScreenState copyWith({
    WorkoutDetails workoutDetails,
    WorkoutMetadata workoutMetadata,
    List<LeaderboardModel> leaderboards,
    BluetoothDevice bluetoothDevice,
    Timer exerciseTimer,
    int currentWorkoutSetIndex,
    bool showNotification,
    int secondsElapsed,
    HashMap<UserModel, int> cuumulativeLeaderboards,
    PostWorkoutSurveyResponseBoxModel postWorkoutSurveyResponseBoxModel,
    UserModel user,
  }) {
    return WorkoutVideoScreenState(
      workoutMetadata: workoutMetadata ?? this.workoutMetadata,
      bluetoothDevice: bluetoothDevice ?? this.bluetoothDevice,
      leaderboards: leaderboards ?? this.leaderboards,
      currentWorkoutSetIndex:
          currentWorkoutSetIndex ?? this.currentWorkoutSetIndex,
      exerciseTimer: exerciseTimer ?? this.exerciseTimer,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
      cumulativeLeaderboards:
          cumulativeLeaderboards ?? this.cumulativeLeaderboards,
      postWorkoutSurveyResponseBoxModel: postWorkoutSurveyResponseBoxModel ??
          this.postWorkoutSurveyResponseBoxModel,
      user: user ?? this.user,
    );
  }

  static HashMap<UserModel, int> initializeCuumulativeLeaderboard(
      List<LeaderboardModel> leaderboards) {
    HashMap<UserModel, int> cumulativeLeaderboards = HashMap();
    leaderboards.first.leaderboardEntries.forEach((element) {
      cumulativeLeaderboards[element.user] = 0;
    });
    return cumulativeLeaderboards;
  }

  HashMap<UserModel, int> updateCuumulativeLeaderboard(
      List<LeaderboardModel> leaderboards,
      HashMap<UserModel, int> cumulativeLeaderboards,
      bool isRest) {
    if (isRest) return cumulativeLeaderboards;
    leaderboards[currentWorkoutSetIndex].leaderboardEntries.forEach((element) {
      cumulativeLeaderboards[element.user] =
          cumulativeLeaderboards[element.user] + element.score.value;
    });
    return cumulativeLeaderboards;
  }

  LeaderboardModel getCumulativeLeaderboard(
    HashMap<UserModel, int> cumulativeLeaderboards,
    UserModel user,
  ) {
    var list = cumulativeLeaderboards.entries.toList();
    list.sort((a, b) => a.value.compareTo(b.value));
    var listLeaderboardEntries = list
        .map(
          (e) => LeaderboardEntryModel(
            user: e.key,
            score: ExerciseScoreModel(
              value: e.value,
              exerciseSetDefinition: null,
            ),
            exerciseSetDefinition: null,
          ),
        )
        .toList();
    return LeaderboardModel.userEntryAlreadyExists(
      leaderboardEntries: listLeaderboardEntries,
      user: user,
    );
  }

  void endClass(Timer exerciseTimer, {BluetoothDevice bluetoothDevice}) {
    exerciseTimer.cancel();
    // Disconnect the bluetooth device
    if (bluetoothDevice != null) bluetoothDevice.disconnect();
  }
}
