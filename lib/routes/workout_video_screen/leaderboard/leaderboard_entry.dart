import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

class LeaderboardEntry extends StatelessWidget {
  // Is this the user or a launchpad leaderboard entry?
  final bool topThree;
  final int position;
  final bool nearestFive;

  static double height = SizeConfig.blockSizeHorizontal * 3;

  LeaderboardEntry({
    @required this.topThree,
    @required this.position,
    @required this.nearestFive,
  });

  static double fontSize = SizeConfig.blockSizeVertical * 2.5;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WorkoutVideoScreenState>(builder: (context, store) {
      if (topThree == true) {
        bool isUser =
            store.state.currentLeaderboard.getUserEntry.user.username ==
                store.state.currentLeaderboard.topThreeEntries[position].user
                    .username;

        return Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      size: SizeConfig.blockSizeVertical * 3,
                      color: position == 0
                          ? Colors.yellow[600]
                          : position == 1
                              ? Colors.grey[350]
                              : Colors.deepOrange[900],
                    ),
                  ),
                ),
                Positioned(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  child: Image.network(
                    store.state.currentLeaderboard.topThreeEntries[position]
                        .user.avatarUrl,
                    height: SizeConfig.blockSizeVertical * 4,
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
            height: SizeConfig.blockSizeVertical * 5,
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
                Positioned(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  child: Image.network(
                    store.state.currentLeaderboard.nearestFiveEntries[position]
                        .user.avatarUrl,
                    height: SizeConfig.blockSizeVertical * 4,
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
      } else {
        return Container();
      }
    });
  }
}
