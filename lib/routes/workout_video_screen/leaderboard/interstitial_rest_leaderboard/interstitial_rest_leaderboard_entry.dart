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
    this.topThree,
    this.position,
    this.nearestFive,
  });
  @override
  _InterstitialRestLeaderboardEntryState createState() => _InterstitialRestLeaderboardEntryState(
      topThree: this.topThree,
      nearestFive: this.nearestFive,
      position: this.position);
}

class _InterstitialRestLeaderboardEntryState extends State<InterstitialRestLeaderboardEntry> {
  final bool topThree;
  final int position;
  final bool nearestFive;
  _InterstitialRestLeaderboardEntryState({this.topThree, this.nearestFive, this.position});

  static double fontSize = SizeConfig.blockSizeVertical * 2.5;

  // Consumes -> LeaderboardModel (from Leaderboard)
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WorkoutVideoScreenState>(builder: (context, store) {
      if (topThree == true) {
        bool isUser =
            store.state.currentLeaderboard.getUserEntry.user.username ==
                store.state.currentLeaderboard.topThreeEntries[position].user
                    .username;

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
                    store.state.currentLeaderboard.topThreeEntries[position]
                        .user.username,
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
                      store.state.currentLeaderboard.topThreeEntries[position]
                          .score.value
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
        bool isUser =
            store.state.currentLeaderboard.getUserEntry.user.username ==
                store.state.currentLeaderboard.nearestFiveEntries[position].user
                    .username;
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
                      store.state.currentLeaderboard
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
                    store.state.currentLeaderboard.nearestFiveEntries[position]
                        .user.username,
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
                      store.state.currentLeaderboard
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
