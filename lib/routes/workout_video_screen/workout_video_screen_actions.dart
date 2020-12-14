
class ChangeToNextExerciseAction {}

class UpdateUserPositionAction {}

class AddScoreValueAction {
  final int newScoreValue;
  final String scoreTag;
  AddScoreValueAction({this.newScoreValue, this.scoreTag});
}

class UpdatePostWorkoutSurveyInputAction {
  final String field;
  final int value;
  UpdatePostWorkoutSurveyInputAction({this.field, this.value});
}

class AddGoodRepAction {}

class AddBadRepAction {}

class ClearScoreAction {}


class UpdateSecondsElapsedAction {
  final int secondsElapsed;
  UpdateSecondsElapsedAction(this.secondsElapsed);
}

class ClearNotificationBarAction {}
