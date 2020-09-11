import 'package:flutter/material.dart';
import 'package:tabletapp/models/exercise_set_model.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/user_model.dart';

// A model that represents one entry in a leaderboard.
// Can be a launchpad leaderboard entry or the real user.
class LeaderboardEntryModel extends ChangeNotifier {
  final UserModel user;
  final ExerciseSetModel exerciseSetDefinition;
  ExerciseScoreModel score;

  LeaderboardEntryModel(
      {this.user, this.exerciseSetDefinition, this.score});

  void changeScoreValue(double newScoreValue) {
    this.score.value = newScoreValue;
    notifyListeners();
  }

  void addGoodRep() {
    this.score.goodReps++;
    notifyListeners();
  }

  void addBadRep() {
    this.score.badReps++;
    notifyListeners();
  }

  void clearScore() {
    this.score.badReps = 0;
    this.score.goodReps = 0;
    this.score.value = 0;
    notifyListeners();
  }
}
