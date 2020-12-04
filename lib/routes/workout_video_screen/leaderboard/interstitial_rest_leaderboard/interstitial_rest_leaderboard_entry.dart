import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

class InterstitialRestLeaderboardEntry extends StatefulWidget {
  // Is this the user or a launchpad leaderboard entry?
  final bool topThree;
  final int position;
  final bool nearestFive;

  static double height = SizeConfig.blockSizeHorizontal * 3;

  InterstitialRestLeaderboardEntry({
    @required this.topThree,
    @required this.position,
    @required this.nearestFive,
  });
  @override
  _InterstitialRestLeaderboardEntryState createState() =>
      _InterstitialRestLeaderboardEntryState(
          topThree: this.topThree,
          nearestFive: this.nearestFive,
          position: this.position);
}

class _InterstitialRestLeaderboardEntryState
    extends State<InterstitialRestLeaderboardEntry> {
  final bool topThree;
  final int position;
  final bool nearestFive;
  _InterstitialRestLeaderboardEntryState(
      {this.topThree, this.nearestFive, this.position});

  static double fontSize = SizeConfig.blockSizeVertical * 2.5;

  // Consumes -> LeaderboardModel (from Leaderboard)
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WorkoutVideoScreenState>(builder: (context, store) {
      var cumulativeLeaderboard =
          store.state.getCumulativeLeaderboard(store.state.user);
      if (topThree == true) {
        bool isUser = store.state.user ==
            cumulativeLeaderboard.topThreeEntries[position].user;
        return Container(
            height: SizeConfig.blockSizeVertical * 3,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    child: Text(
                      (position + 1).toString() + ".",
                      style: TextStyle(
                        color: isUser
                            ? ColorConstants.launchpadGreen
                            : ColorConstants.launchpadPrimaryWhite,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    cumulativeLeaderboard
                        .topThreeEntries[position].user.username,
                    style: TextStyle(
                      color: isUser
                          ? ColorConstants.launchpadGreen
                          : ColorConstants.launchpadPrimaryWhite,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      cumulativeLeaderboard
                          .topThreeEntries[position].score.value
                          .toString(),
                      style: TextStyle(
                        color: isUser
                            ? ColorConstants.launchpadGreen
                            : ColorConstants.launchpadPrimaryWhite,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ));
      } else if (nearestFive == true) {
        print(cumulativeLeaderboard.nearestFiveEntries[position]);
        bool isUser = cumulativeLeaderboard.getUserEntry.user.username ==
            cumulativeLeaderboard.nearestFiveEntries[position].user.username;
        return Container(
            height: SizeConfig.blockSizeVertical * 3,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    child: Text(
                      cumulativeLeaderboard
                              .nearestFiveEntriesPositions[position]
                              .toString() +
                          ".",
                      style: TextStyle(
                        color: isUser
                            ? ColorConstants.launchpadGreen
                            : ColorConstants.launchpadPrimaryWhite,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    cumulativeLeaderboard
                        .nearestFiveEntries[position].user.username,
                    style: TextStyle(
                      color: isUser
                          ? ColorConstants.launchpadGreen
                          : ColorConstants.launchpadPrimaryWhite,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      cumulativeLeaderboard
                          .nearestFiveEntries[position].score.value
                          .toString(),
                      style: TextStyle(
                        color: isUser
                            ? ColorConstants.launchpadGreen
                            : ColorConstants.launchpadPrimaryWhite,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ));
      }
    });
  }
}
