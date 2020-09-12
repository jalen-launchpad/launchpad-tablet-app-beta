import 'package:redux/redux.dart';
import 'workout_video_screen_model.dart';

class ChangeToNextExerciseAction {}

class UpdateUserPositionAction {}

class ChangeScoreValueAction {
  final double newScoreValue;
  ChangeScoreValueAction({this.newScoreValue});
}

class AddGoodRepAction {}

class AddBadRepAction {}

class ClearScoreAction {}

WorkoutVideoScreenModel Function(WorkoutVideoScreenModel, dynamic) rootReducer =
    combineReducers([
  TypedReducer<WorkoutVideoScreenModel, ChangeToNextExerciseAction>(
      changeToNextExerciseReducer),
  TypedReducer<WorkoutVideoScreenModel, UpdateUserPositionAction>(
      updateUserPositionReducer),
  TypedReducer<WorkoutVideoScreenModel, ChangeScoreValueAction>(
      changeScoreValueReducer),
  TypedReducer<WorkoutVideoScreenModel, AddGoodRepAction>(addGoodRepReducer),
  TypedReducer<WorkoutVideoScreenModel, AddBadRepAction>(addBadRepReducer),
  TypedReducer<WorkoutVideoScreenModel, ClearScoreAction>(clearScoreReducer),
]);

final Function(WorkoutVideoScreenModel, ClearScoreAction) clearScoreReducer =
    (WorkoutVideoScreenModel model, ClearScoreAction action) {
  var list = model.userLeaderboardEntries;
  list[model.currentExerciseIndex].score.goodReps = 0;
  list[model.currentExerciseIndex].score.badReps = 0;
  list[model.currentExerciseIndex].score.value = 0;
  return model.copyWith(userLeaderboardEntries: list);
};

final Function(WorkoutVideoScreenModel, AddGoodRepAction) addGoodRepReducer =
    (WorkoutVideoScreenModel model, AddGoodRepAction action) {

  // UPDATE ALL SCORE REFERENCES IN OTHER REDUCERS!!
  var list = model.userLeaderboardEntries;
  list[model.currentExerciseIndex].score.goodReps++;
  var leaderboards = model.leaderboards;
  var leaderboardModel = leaderboards[model.currentExerciseIndex];
  leaderboardModel.userEntry.score.goodReps++;
  return model.copyWith(
      userLeaderboardEntries: list, leaderboards: leaderboards);
};

// Add Bad Rep Reducer
final Function(WorkoutVideoScreenModel, AddBadRepAction) addBadRepReducer =
    (WorkoutVideoScreenModel model, AddBadRepAction action) {
  var list = model.userLeaderboardEntries;
  list[model.currentExerciseIndex].score.badReps++;
  var leaderboards = model.leaderboards;
  var leaderboardModel = leaderboards[model.currentExerciseIndex];
  leaderboardModel.userEntry.score.badReps++;
  return model.copyWith(
      userLeaderboardEntries: list, leaderboards: leaderboards);
};

// Change Score Value Reducer
final Function(WorkoutVideoScreenModel, ChangeScoreValueAction)
    changeScoreValueReducer =
    (WorkoutVideoScreenModel model, ChangeScoreValueAction action) {
  var list = model.userLeaderboardEntries;
  list[model.currentExerciseIndex].score.value = action.newScoreValue;
  return model.copyWith(userLeaderboardEntries: list);
};

// Change To Next Exercise Reducer
final Function(WorkoutVideoScreenModel, ChangeToNextExerciseAction)
    changeToNextExerciseReducer =
    (WorkoutVideoScreenModel model, ChangeToNextExerciseAction action) {
  var newModel = model.copyWith();
  newModel.changeToNextExercise();
  return newModel;
};

// Update User Position Reducer
final Function(WorkoutVideoScreenModel, UpdateUserPositionAction)
    updateUserPositionReducer =
    (WorkoutVideoScreenModel model, UpdateUserPositionAction action) {
  var newModel = model.copyWith();
  for (int index =
          newModel.leaderboards[newModel.currentExerciseIndex].userPosition;
      index <
          newModel.leaderboards[newModel.currentExerciseIndex]
              .leaderboardEntries.length;
      index++) {
    if (newModel.userLeaderboardEntries[newModel.currentExerciseIndex].score
            .getValue <
        newModel.leaderboards[newModel.currentExerciseIndex].nextScoreToBeat) {
      return newModel;
    }
    if (newModel.userLeaderboardEntries[newModel.currentExerciseIndex].score
            .getValue <
        newModel.leaderboards[newModel.currentExerciseIndex]
            .leaderboardEntries[index].score.getValue) {
      // User score is less than that at index, therefore, they are one spot below.
      newModel.leaderboards[newModel.currentExerciseIndex].userPosition = index;
      newModel.leaderboards[newModel.currentExerciseIndex].nextScoreToBeat =
          newModel.leaderboards[newModel.currentExerciseIndex]
              .leaderboardEntries[index].score.getValue;
      return newModel;
    }
  }
  // Max position in leaderboard
  newModel.leaderboards[newModel.currentExerciseIndex].userPosition =
      newModel.leaderboards[newModel.currentExerciseIndex].maxPosition;
  return newModel;
};
