import 'package:flutter/material.dart';
import 'package:tabletapp/widgets/workout_view/metrics/exercise_leaderboard/exercise_leaderboard_entry_model.dart';

class ExerciseLeaderboardModel extends ChangeNotifier {

  // Launchpad's leaderboard for a given exercise.
  final List<ExerciseLeaderboardEntryModel> leaderboardEntries;

  // The user is not saved in the leaderboard list until post exercise.
  // There's no manipulation of the leaderboard entries to save speed.
  ExerciseLeaderboardEntryModel userEntry;
  int userPosition;
  int nextScoreToBeat;

  // Function that takes in a new user score and updates the user's position in the leaderboards.
  // @params
  // int score - The new user score.
  void updateUserPosition(int score) {
    for (int index = userPosition; index < leaderboardEntries.length; index++) {
      if (score < nextScoreToBeat) {
        return;
      }
      if (score < leaderboardEntries[index].score.getValue) {
        // User score is less than that at index, therefore, they are one spot below.
        userPosition = index;
        nextScoreToBeat = leaderboardEntries[index].score.getValue;
        notifyListeners();
        return;
      }
    }
    // Max position in leaderboard
    userPosition = leaderboardEntries.length;
    notifyListeners();
  }

  // Get the leaderboard entry that is one position above the user.
  ExerciseLeaderboardEntryModel getAbove() {
    return (userPosition == leaderboardEntries.length - 1)
        ? null
        : leaderboardEntries[userPosition];
  }

  // Get the leaderboard entry that is one position below the user.
  ExerciseLeaderboardEntryModel getBelow() {
    return (userPosition == 0) ? null : leaderboardEntries[userPosition - 1];
  }

  ExerciseLeaderboardModel(
      {this.leaderboardEntries,
      this.userPosition,
      this.nextScoreToBeat,
      this.userEntry});
}
