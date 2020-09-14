import 'package:flutter/material.dart';

import 'leaderboard_entry_model.dart';

class LeaderboardModel {
  // Launchpad's leaderboard for a given exercise.
  final List<LeaderboardEntryModel> leaderboardEntries;

  // The user entry, which also appears in
  // leaderboardEntries at index userPosition.
  LeaderboardEntryModel userEntry;

  int userPosition;
  int nextScoreToBeat;

  int get maxPosition => leaderboardEntries.length;
  bool get userIsLeader => userPosition == leaderboardEntries.length - 1;
  bool get userIsLast => userPosition == 0;
  LeaderboardEntryModel get getUserEntry => leaderboardEntries[userPosition];

  // Get the leaderboard entry that is one position above the user.
  LeaderboardEntryModel getAbove() {
    return userIsLeader ? null : leaderboardEntries[userPosition + 1];
  }

  // Get the leaderboard entry that is one position below the user.
  LeaderboardEntryModel getBelow() {
    return userIsLast ? null : leaderboardEntries[userPosition - 1];
  }

  LeaderboardModel(
      {this.leaderboardEntries,
      this.userPosition,
      this.nextScoreToBeat,
      this.userEntry}) {
    this.leaderboardEntries.insert(0, this.
    userEntry);
  }
}
