import 'leaderboard_entry_model.dart';

class LeaderboardModel {
  // Launchpad's leaderboard for a given exercise. Sorted from low score -> high score.
  final List<LeaderboardEntryModel> leaderboardEntries;

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

  List<int> getNearestFiveEntriesPositions() {
    List<int> list = [];
    if (userIsLeader || userIsSecondPlace) {
      print("userIsLeader");
      list.add(1);
      list.add(2);
      list.add(3);
      list.add(4);
      list.add(5);
    } else if (userIsLast || userIsSecondToLast) {
      print("userIsLast");
      list.add(leaderboardEntries.length - 4);
      list.add(leaderboardEntries.length - 3);
      list.add(leaderboardEntries.length - 2);
      list.add(leaderboardEntries.length - 1);
      list.add(leaderboardEntries.length);
    } else {
      print("user is in between");
      list.add((leaderboardEntries.length - userPosition) + 1 - 2);
      list.add((leaderboardEntries.length - userPosition) + 1 - 1);
      list.add((leaderboardEntries.length - userPosition) + 1);
      list.add((leaderboardEntries.length - userPosition) + 1 + 1);
      list.add((leaderboardEntries.length - userPosition) + 1 + 2);
    }

    return list;
  }

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
      userPosition: this.userPosition,
      userEntry: this.userEntry,
    );
  }

  LeaderboardModel(
      {this.leaderboardEntries, this.userPosition, this.userEntry}) {
    this.leaderboardEntries.insert(0, this.userEntry);
    this.topThreeEntries = getTopThreeEntries();
    this.nearestFiveEntries = getNearestFiveEntries();
    this.nearestFiveEntriesPositions = getNearestFiveEntriesPositions();
  }
}
