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
import 'notification_bar/workout_notification.dart';
import 'post_workout_survey/post_workout_survey_response_box_model.dart';

class WorkoutVideoScreenState {
  // All video metadata.
  final WorkoutMetadata workoutMetadata;
  // A list of WorkoutLeaderboardEntries pre-populated with previous users.
  final List<LeaderboardModel> leaderboards;
  final HashMap<UserModel, int> cumulativeLeaderboards;
  // The bluetooth connected Launchpad Companion App
  final BluetoothDevice bluetoothDevice;
  final bool showNotification;
  // The workout notification currently shown on screen.
  final WorkoutNotification workoutNotification;
  Timer exerciseTimer;
  int currentWorkoutSetIndex;
  final int secondsElapsed;
  final PostWorkoutSurveyResponseBoxModel postWorkoutSurveyResponseBoxModel;
  final UserModel user;

  WorkoutVideoScreenState({
    @required this.workoutMetadata,
    @required this.bluetoothDevice,
    @required this.leaderboards,
    @required this.cumulativeLeaderboards,
    @required this.postWorkoutSurveyResponseBoxModel,
    @required this.user,
    this.currentWorkoutSetIndex = 0,
    this.exerciseTimer,
    this.showNotification = false,
    this.workoutNotification,
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
    WorkoutNotification workoutNotification,
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
      workoutNotification: workoutNotification ?? this.workoutNotification,
      showNotification: showNotification ?? this.showNotification,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
      cumulativeLeaderboards:
          cuumulativeLeaderboards ?? this.cumulativeLeaderboards,
      postWorkoutSurveyResponseBoxModel: postWorkoutSurveyResponseBoxModel ??
          this.postWorkoutSurveyResponseBoxModel,
      user: user ?? this.user,
    );
  }

  void changeToNextExercise() {
    currentWorkoutSetIndex++;
  }

  void initializeCuumulativeLeaderboard() {
    leaderboards[currentExerciseIndex].leaderboardEntries.forEach((element) {
      cumulativeLeaderboards[element.user] = 0;
    });
  }

  void updateCuumulativeLeaderboard() {
    if (currentExercise.isRest) return;
    leaderboards[currentExerciseIndex].leaderboardEntries.forEach((element) {
      cumulativeLeaderboards[element.user] =
          cumulativeLeaderboards[element.user] + element.score.value;
    });
  }

  LeaderboardModel getCumulativeLeaderboard(UserModel user) {
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

  LeaderboardModel get currentLeaderboard => leaderboards[currentExerciseIndex];
  WorkoutSetModel get currentExercise => workoutSets[currentWorkoutSetIndex];
  WorkoutSetModel get previousExercise =>
      workoutSets[currentWorkoutSetIndex > 0 ? currentWorkoutSetIndex - 1 : 0];
  WorkoutSetModel get nextExercise =>
      !isLastSet ? workoutSets[currentWorkoutSetIndex + 1] : null;
  bool get isLastSet => currentWorkoutSetIndex == (workoutSets.length - 1);
  bool get classIsOver => currentWorkoutSetIndex >= workoutSets.length;
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
