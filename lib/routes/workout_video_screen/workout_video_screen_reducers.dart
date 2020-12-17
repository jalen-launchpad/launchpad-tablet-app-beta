import 'package:redux/redux.dart';
import 'package:tabletapp/routes/workout_video_screen/post_workout_survey/post_workout_survey_response_box_model.dart';
import 'workout_video_screen_actions.dart';
import 'workout_video_screen_state.dart';

// Root Reducer that contains all other reducers.
WorkoutVideoScreenState Function(WorkoutVideoScreenState, dynamic) rootReducer =
    combineReducers([
  TypedReducer<WorkoutVideoScreenState, ChangeToNextExerciseAction>(
      changeToNextExerciseReducer),
  TypedReducer<WorkoutVideoScreenState, UpdateUserPositionAction>(
      updateUserPositionReducer),
  TypedReducer<WorkoutVideoScreenState, AddScoreValueAction>(
      addScoreValueAction),
  TypedReducer<WorkoutVideoScreenState, AddGoodRepAction>(addGoodRepReducer),
  TypedReducer<WorkoutVideoScreenState, AddBadRepAction>(addBadRepReducer),
  TypedReducer<WorkoutVideoScreenState, ClearScoreAction>(clearScoreReducer),
  TypedReducer<WorkoutVideoScreenState, UpdateSecondsElapsedAction>(
      updateSecondsElapsedReducer),
  TypedReducer<WorkoutVideoScreenState, UpdatePostWorkoutSurveyInputAction>(
      updatePostWorkoutSurveyInputReducer),
]);

final Function(WorkoutVideoScreenState, UpdateSecondsElapsedAction)
    updateSecondsElapsedReducer =
    (WorkoutVideoScreenState state, UpdateSecondsElapsedAction action) {
  return state.copyWith(
    secondsElapsed: action.secondsElapsed,
  );
};

// Clear Score Reducer
final Function(WorkoutVideoScreenState, ClearScoreAction) clearScoreReducer =
    (WorkoutVideoScreenState state, ClearScoreAction action) {
  var newState = state.copyWith();
  var list = newState.leaderboards;
  list[newState.currentWorkoutSetIndex].userEntry.score.goodReps = 0;
  list[newState.currentWorkoutSetIndex].userEntry.score.badReps = 0;
  list[newState.currentWorkoutSetIndex].userEntry.score.value = 0;
  return newState;
};

// Add Good Rep Reducer
final Function(WorkoutVideoScreenState, AddGoodRepAction) addGoodRepReducer =
    (WorkoutVideoScreenState state, AddGoodRepAction action) {
  // UPDATE ALL SCORE REFERENCES IN OTHER REDUCERS!!
  var newState = state.copyWith();
  newState
      .leaderboards[newState.currentWorkoutSetIndex].userEntry.score.goodReps++;
  return newState;
};

// Add Bad Rep Reducer
final Function(WorkoutVideoScreenState, AddBadRepAction) addBadRepReducer =
    (WorkoutVideoScreenState state, AddBadRepAction action) {
  var newState = state.copyWith();
  newState
      .leaderboards[newState.currentWorkoutSetIndex].userEntry.score.badReps++;
  return newState;
};

// Change Score Value Reducer
final Function(WorkoutVideoScreenState, AddScoreValueAction)
    addScoreValueAction =
    (WorkoutVideoScreenState state, AddScoreValueAction action) {
  var newState = state.copyWith();

  if (newState.currentExercise.isRest == true) {
    return newState;
  }
  // If this exercise's scoring tag doesn't match the scoring tag of the incoming action...
  if (newState.currentExercise.exerciseSetDefinition.scoreTag !=
      action.scoreTag) {
    // Don't change the state.
    return newState;
  }

  newState.leaderboards[newState.currentWorkoutSetIndex].userEntry.score
      .value += (state.currentExercise.exerciseSetDefinition.scoreMultiplier *
          action.newScoreValue)
      .floor();
  if (newState.currentExercise.exerciseSetDefinition.maxScore != null &&
      newState.currentUserScore >
          newState.currentExercise.exerciseSetDefinition.maxScore) {
    newState.currentUserScore =
        newState.currentExercise.exerciseSetDefinition.maxScore;
  }

  return newState;
};

// Change To Next Exercise Reducer.
// This moves the leaderboard as well as the metadata displayed on screen.
Function(WorkoutVideoScreenState, ChangeToNextExerciseAction)
    changeToNextExerciseReducer =
    (WorkoutVideoScreenState state, ChangeToNextExerciseAction action) {
  var newState = state.copyWith(
    cuumulativeLeaderboards: state.updateCuumulativeLeaderboard(
      state.leaderboards,
      state.cumulativeLeaderboards,
      state.currentExercise.isRest,
    ),
    currentWorkoutSetIndex: state.currentWorkoutSetIndex + 1,
  );
  return newState;
};

// Update
Function(WorkoutVideoScreenState, UpdatePostWorkoutSurveyInputAction)
    updatePostWorkoutSurveyInputReducer =
    (WorkoutVideoScreenState state, UpdatePostWorkoutSurveyInputAction action) {
  var newState = state.copyWith(
      postWorkoutSurveyResponseBoxModel: PostWorkoutSurveyResponseBoxModel(
    action.field == "Overall"
        ? action.value
        : state.postWorkoutSurveyResponseBoxModel.overall,
    action.field == "Instructor"
        ? action.value
        : state.postWorkoutSurveyResponseBoxModel.instructor,
    action.field == "Fun"
        ? action.value
        : state.postWorkoutSurveyResponseBoxModel.fun,
    action.field == "Difficulty"
        ? action.value
        : state.postWorkoutSurveyResponseBoxModel.difficulty,
  ));

  return newState;
};

// Update User Position Reducer
final Function(WorkoutVideoScreenState, UpdateUserPositionAction)
    updateUserPositionReducer =
    (WorkoutVideoScreenState state, UpdateUserPositionAction action) {
  var newState = state.copyWith();
  var currentLeaderboard =
      newState.leaderboards[newState.currentWorkoutSetIndex];
  for (int index = currentLeaderboard.userPosition;
      index < currentLeaderboard.maxPosition;
      index++) {
    // If the user is now the leader, exit.
    if (currentLeaderboard.userIsLeader) {
      break;
    }

    // If the user score is less than the nextToBeat,
    // no change in position.
    if (currentLeaderboard.getUserEntry.score.getValue <
        currentLeaderboard.nextScoreToBeat) {
      break;
    } else {
      // If the user score is larger than next to beat,
      // there is a change in position.

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
      // Update user position.
      currentLeaderboard.userPosition++;
    }
  }
  newState.currentLeaderboard.nearestFiveEntries =
      newState.currentLeaderboard.getNearestFiveEntries();
  newState.currentLeaderboard.topThreeEntries =
      newState.currentLeaderboard.getTopThreeEntries();
  newState.currentLeaderboard.nearestFiveEntriesPositions =
      newState.currentLeaderboard.getNearestFiveEntriesPositions();

  return newState;
};
