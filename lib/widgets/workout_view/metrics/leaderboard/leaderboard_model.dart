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

  // Get the leaderboard entry that is one position above the user.
  LeaderboardEntryModel getAbove() {
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
