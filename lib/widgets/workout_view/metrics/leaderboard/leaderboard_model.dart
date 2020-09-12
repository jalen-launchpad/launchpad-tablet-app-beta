import 'package:flutter/material.dart';

import 'leaderboard_entry_model.dart';

class LeaderboardModel extends ChangeNotifier {
  // Launchpad's leaderboard for a given exercise.
  final List<LeaderboardEntryModel> leaderboardEntries;

  // The user is not saved in the leaderboard list until post exercise.
  // There's no manipulation of the leaderboard entries to save speed.
  LeaderboardEntryModel userEntry;
  int userPosition;
  int nextScoreToBeat;

  int get maxPosition => leaderboardEntries.length - 1;

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
    userPosition = maxPosition;
    notifyListeners();
  }

  // Get the leaderboard entry that is one position above the user.
  LeaderboardEntryModel getAbove() {
    print("userPosition" + userPosition.toString());
    print("leaderboardEntries.length" + leaderboardEntries.length.toString());
    return (userPosition == maxPosition)
        ? null
        : leaderboardEntries[userPosition];
  }

  // Get the leaderboard entry that is one position below the user.
  LeaderboardEntryModel getBelow() {
    return (userPosition == 0)
        ? null
        : leaderboardEntries[
            userPosition == maxPosition ? userPosition : userPosition - 1];
  }

  LeaderboardModel(
      {this.leaderboardEntries,
      this.userPosition,
      this.nextScoreToBeat,
      this.userEntry});
}