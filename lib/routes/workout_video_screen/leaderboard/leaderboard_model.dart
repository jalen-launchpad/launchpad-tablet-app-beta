import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/user_model.dart';

import 'leaderboard_entry_model.dart';

class LeaderboardModel {
  // Launchpad's leaderboard for a given exercise. Sorted from low score -> high score.
  final List<LeaderboardEntryModel> leaderboardEntries;
  final UserModel user;
  // The user entry, which also appears in
  // leaderboardEntries at index userPosition.
  LeaderboardEntryModel userEntry;

  List<int> nearestFiveEntriesPositions;
  List<LeaderboardEntryModel> nearestFiveEntries;
  List<LeaderboardEntryModel> topThreeEntries;

  int userPosition;

  int get nextScoreToBeat =>
      userIsLeader ? -1 : leaderboardEntries[userPosition + 1].score.value;
  int get maxPosition => leaderboardEntries.length;
  bool get userIsLeader => userPosition == leaderboardEntries.length - 1;
  bool get userIsSecondPlace => userPosition == leaderboardEntries.length - 2;
  bool get userIsTopTen => userPosition >= leaderboardEntries.length - 9;
  bool get userIsSecondToLast => userPosition == 1;
  bool get userIsLast => userPosition == 0;
  LeaderboardEntryModel get getUserEntry => leaderboardEntries[userPosition];
  List<LeaderboardEntryModel> get getTopTenScores =>
      leaderboardEntries.reversed.toList().sublist(0, 10);

  // Generate a LeaderboardModel with empty user entries.
  LeaderboardModel({this.leaderboardEntries, this.user}) {
    userEntry = LeaderboardEntryModel(
      exerciseSetDefinition: this.leaderboardEntries[0]?.exerciseSetDefinition,
      user: user,
      score: ExerciseScoreModel(
        exerciseSetDefinition:
            this.leaderboardEntries[0]?.exerciseSetDefinition,
        value: 0,
      ),
    );
    userPosition = 0;
    this.leaderboardEntries.insert(userPosition, userEntry);
    // Initialize the user leaderboard entries with default values.
    this.topThreeEntries = getTopThreeEntries();
    this.nearestFiveEntries = getNearestFiveEntries();
    this.nearestFiveEntriesPositions = getNearestFiveEntriesPositions();
  }

  // Generate a leaderboard where the user already exists.
  // This use case is for converting HashMap cumulative leaderboard
  // to a LeaderboardModel.
  LeaderboardModel.userEntryAlreadyExists(
      {this.leaderboardEntries, this.user}) {
    userPosition = this
        .leaderboardEntries
        .indexWhere((element) => element.user == this.user);
    this.leaderboardEntries.forEach((element) {
      print(element.score);
    });
    userEntry = this.leaderboardEntries[userPosition];
    this.topThreeEntries = getTopThreeEntries();
    this.nearestFiveEntries = getNearestFiveEntries();
    this.nearestFiveEntriesPositions = getNearestFiveEntriesPositions();
  }

  // Get the nearest five leaderboard entries to the user, including the user.
  // The entries correspond to the same index that represents their position
  // in getNearestFiveEntriesPositions.
  List<LeaderboardEntryModel> getNearestFiveEntries() {
    List<LeaderboardEntryModel> list = [];
    if (userIsLeader) {
      list.add(userEntry);
      list.add(leaderboardEntries[userPosition - 1]);
      list.add(leaderboardEntries[userPosition - 2]);
      list.add(leaderboardEntries[userPosition - 3]);
      list.add(leaderboardEntries[userPosition - 4]);
    } else if (userIsSecondPlace) {
      list.add(leaderboardEntries[userPosition + 1]);
      list.add(userEntry);
      list.add(leaderboardEntries[userPosition - 1]);
      list.add(leaderboardEntries[userPosition - 2]);
      list.add(leaderboardEntries[userPosition - 3]);
    } else if (userIsSecondToLast) {
      list.add(leaderboardEntries[userPosition + 3]);
      list.add(leaderboardEntries[userPosition + 2]);
      list.add(leaderboardEntries[userPosition + 1]);
      list.add(userEntry);
      list.add(leaderboardEntries[userPosition - 1]);
    } else if (userIsLast) {
      list.add(leaderboardEntries[userPosition + 4]);
      list.add(leaderboardEntries[userPosition + 3]);
      list.add(leaderboardEntries[userPosition + 2]);
      list.add(leaderboardEntries[userPosition + 1]);
      list.add(userEntry);
    } else {
      list.add(leaderboardEntries[userPosition + 2]);
      list.add(leaderboardEntries[userPosition + 1]);
      list.add(userEntry);
      list.add(leaderboardEntries[userPosition - 1]);
      list.add(leaderboardEntries[userPosition - 2]);
    }
    return list;
  }

  // Get the leaderboard position of the nearest 5 positions to the user, including the user.
  List<int> getNearestFiveEntriesPositions() {
    List<int> list = [];
    if (userIsLeader || userIsSecondPlace) {
      list.add(1);
      list.add(2);
      list.add(3);
      list.add(4);
      list.add(5);
    } else if (userIsLast || userIsSecondToLast) {
      list.add(leaderboardEntries.length - 4);
      list.add(leaderboardEntries.length - 3);
      list.add(leaderboardEntries.length - 2);
      list.add(leaderboardEntries.length - 1);
      list.add(leaderboardEntries.length);
    } else {
      list.add((leaderboardEntries.length - userPosition) + 1 - 2);
      list.add((leaderboardEntries.length - userPosition) + 1 - 1);
      list.add((leaderboardEntries.length - userPosition) + 1);
      list.add((leaderboardEntries.length - userPosition) + 1 + 1);
      list.add((leaderboardEntries.length - userPosition) + 1 + 2);
    }

    return list;
  }

  // Return the top three entries from the current Leaderboard.
  // Top entry is at index 0.
  List<LeaderboardEntryModel> getTopThreeEntries() {
    return [
      leaderboardEntries[leaderboardEntries.length - 1],
      leaderboardEntries[leaderboardEntries.length - 2],
      leaderboardEntries[leaderboardEntries.length - 3]
    ];
  }

  LeaderboardModel copy() {
    return LeaderboardModel(
      leaderboardEntries: this.leaderboardEntries,
      user: this.user,
    );
  }
}
