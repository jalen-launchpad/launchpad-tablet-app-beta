import 'dart:math';

import 'package:redux/redux.dart';
import 'workout_video_screen_actions.dart';
import 'workout_video_screen_state.dart';

// Root Reducer that contains all other reducers.
WorkoutVideoScreenState Function(WorkoutVideoScreenState, dynamic) rootReducer =
    combineReducers([
  TypedReducer<WorkoutVideoScreenState, ChangeToNextExerciseAction>(
      changeToNextExerciseReducer),
  TypedReducer<WorkoutVideoScreenState, UpdateUserPositionAction>(
      updateUserPositionReducer),
  TypedReducer<WorkoutVideoScreenState, ChangeScoreValueAction>(
      changeScoreValueReducer),
  TypedReducer<WorkoutVideoScreenState, AddGoodRepAction>(addGoodRepReducer),
  TypedReducer<WorkoutVideoScreenState, AddBadRepAction>(addBadRepReducer),
  TypedReducer<WorkoutVideoScreenState, ClearScoreAction>(clearScoreReducer),
  TypedReducer<WorkoutVideoScreenState, UpdateNotificationBarAction>(
      updateNotificationBarReducer),
  TypedReducer<WorkoutVideoScreenState, ClearNotificationBarAction>(
      clearNotificationBarReducer),
]);

final Function(WorkoutVideoScreenState, ClearNotificationBarAction)
    clearNotificationBarReducer =
    (WorkoutVideoScreenState state, ClearNotificationBarAction action) {
  return state.copyWith(
    showNotification: false,
    workoutNotification: null,
  );
};

final Function(WorkoutVideoScreenState, UpdateNotificationBarAction)
    updateNotificationBarReducer =
    (WorkoutVideoScreenState state, UpdateNotificationBarAction action) {
  print(action.workoutNotification.notification);
  var newState = state.copyWith(
    showNotification: true,
    workoutNotification: action.workoutNotification,
  );
  print(newState.workoutNotification.notification);
  return newState;
};
// Clear Score Reducer
final Function(WorkoutVideoScreenState, ClearScoreAction) clearScoreReducer =
    (WorkoutVideoScreenState state, ClearScoreAction action) {
  var newState = state.copyWith();
  var list = newState.leaderboards;
  list[newState.currentExerciseIndex].userEntry.score.goodReps = 0;
  list[newState.currentExerciseIndex].userEntry.score.badReps = 0;
  list[newState.currentExerciseIndex].userEntry.score.value = 0;
  return newState;
};

// Add Good Rep Reducer
final Function(WorkoutVideoScreenState, AddGoodRepAction) addGoodRepReducer =
    (WorkoutVideoScreenState state, AddGoodRepAction action) {
  // UPDATE ALL SCORE REFERENCES IN OTHER REDUCERS!!
  var newState = state.copyWith();
  newState
      .leaderboards[newState.currentExerciseIndex].userEntry.score.goodReps++;
  return newState;
};

// Add Bad Rep Reducer
final Function(WorkoutVideoScreenState, AddBadRepAction) addBadRepReducer =
    (WorkoutVideoScreenState state, AddBadRepAction action) {
  var newState = state.copyWith();
  newState
      .leaderboards[newState.currentExerciseIndex].userEntry.score.badReps++;
  return newState;
};

// Change Score Value Reducer
final Function(WorkoutVideoScreenState, ChangeScoreValueAction)
    changeScoreValueReducer =
    (WorkoutVideoScreenState state, ChangeScoreValueAction action) {
  var newState = state.copyWith();
  newState.leaderboards[newState.currentExerciseIndex].userEntry.score.value =
      action.newScoreValue;
  return newState;
};

// Change To Next Exercise Reducer
final Function(WorkoutVideoScreenState, ChangeToNextExerciseAction)
    changeToNextExerciseReducer =
    (WorkoutVideoScreenState state, ChangeToNextExerciseAction action) {
  var newState = state.copyWith();
  newState.changeToNextExercise();
  return newState;
};

// Update User Position Reducer
final Function(WorkoutVideoScreenState, UpdateUserPositionAction)
    updateUserPositionReducer =
    (WorkoutVideoScreenState state, UpdateUserPositionAction action) {
  var newState = state.copyWith();
  var currentLeaderboard = newState.leaderboards[newState.currentExerciseIndex];

  for (int index = currentLeaderboard.userPosition;
      index < currentLeaderboard.maxPosition;
      index++) {
    // If the user is now the leader, exit.
    if (currentLeaderboard.userIsLeader) {
      return newState;
    }

    // If the user score is less than the nextToBeat,
    // no change in position.
    if (currentLeaderboard.getUserEntry.score.getValue <
        currentLeaderboard.nextScoreToBeat) {
      return newState;
    } else {
      // If the user score is larger than next to beat,
      // there is a change in position.

      // IS THIS EASIER TO DO WITH REMOVING INDEX, THEN ADDING BACK IN?

      // Overtaken entry.
      var overtakenEntry = currentLeaderboard
          .leaderboardEntries[currentLeaderboard.userPosition + 1];
      // Replace overtaken entry with user entry.
      currentLeaderboard
              .leaderboardEntries[currentLeaderboard.userPosition + 1] =
          currentLeaderboard.getUserEntry;
      // Replace old user entry position with overtaken entry.
      currentLeaderboard.leaderboardEntries[currentLeaderboard.userPosition] =
          overtakenEntry;
      currentLeaderboard.userPosition++;
      currentLeaderboard.nextScoreToBeat = currentLeaderboard.userIsLeader
          ? -1
          : currentLeaderboard
              .leaderboardEntries[currentLeaderboard.userPosition + 1]
              .score
              .getValue;
    }
  }
  return newState;
};
