import 'notification_bar/workout_notification.dart';

class ChangeToNextExerciseAction {}

class UpdateUserPositionAction {}

class ChangeScoreValueAction {
  final int newScoreValue;
  ChangeScoreValueAction({this.newScoreValue});
}

class AddGoodRepAction {}

class AddBadRepAction {}

class ClearScoreAction {}

class UpdateNotificationBarAction {
  WorkoutNotification workoutNotification;
  UpdateNotificationBarAction({this.workoutNotification});
}

class ClearNotificationBarAction {}
