import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import '../leaderboard_model.dart';

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
    return StoreConnector<WorkoutVideoScreenState, LeaderboardModel>(
        converter: (store) => store.state.getCumulativeLeaderboard(
              store.state.cumulativeLeaderboards,
              store.state.user,
            ),
        builder: (context, leaderboard) {
          if (topThree == true) {
            bool isUser =
                leaderboard.user == leaderboard.topThreeEntries[position].user;
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        leaderboard.topThreeEntries[position].user.username,
                        style: TextStyle(
                          color: isUser
                              ? ColorConstants.launchpadGreen
                              : ColorConstants.launchpadPrimaryWhite,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.blockSizeHorizontal * 5,
                      child: Image.network(
                        leaderboard.topThreeEntries[position].user.avatarUrl,
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          leaderboard.topThreeEntries[position].score.value
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
            print(leaderboard.nearestFiveEntries[position]);
            bool isUser = leaderboard.getUserEntry.user.username ==
                leaderboard.nearestFiveEntries[position].user.username;
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
                          leaderboard.nearestFiveEntriesPositions[position]
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
                        leaderboard.nearestFiveEntries[position].user.username,
                        style: TextStyle(
                          color: isUser
                              ? ColorConstants.launchpadGreen
                              : ColorConstants.launchpadPrimaryWhite,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.blockSizeHorizontal * 5,
                      child: Image.network(
                        leaderboard.nearestFiveEntries[position].user.avatarUrl,
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          leaderboard.nearestFiveEntries[position].score.value
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
