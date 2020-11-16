import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import 'leaderboard.dart';
import 'leaderboard_entry_model.dart';
import 'leaderboard_model.dart';

class LeaderboardEntry extends StatefulWidget {
  final LeaderboardEntryModel exerciseLeaderboardEntryModel;
  // Is this the user or a launchpad leaderboard entry?
  final bool isUser;
  // Is this the launchpad leaderboard entry one spot above the user?
  final bool isAbove;
  // Is this the launchpad leaderboard entry one spot below the user?
  final bool isBelow;

  static double height = SizeConfig.blockSizeHorizontal * 3;

  LeaderboardEntry(
      {this.exerciseLeaderboardEntryModel,
      this.isUser = false,
      this.isAbove = false,
      this.isBelow = false});
  @override
  _LeaderboardEntryState createState() => _LeaderboardEntryState(
      exerciseLeaderboardEntryModel: this.exerciseLeaderboardEntryModel,
      isAbove: this.isAbove,
      isBelow: this.isBelow,
      isUser: this.isUser);
}

class _LeaderboardEntryState extends State<LeaderboardEntry> {
  LeaderboardEntryModel exerciseLeaderboardEntryModel;
  int offset;
  final bool isUser;
  final bool isAbove;
  final bool isBelow;

  _LeaderboardEntryState(
      {this.exerciseLeaderboardEntryModel,
      this.isUser,
      this.isAbove,
      this.isBelow});

  static double fontSize = SizeConfig.blockSizeVertical * 2.5;

  // Consumes -> LeaderboardModel (from Leaderboard)
  @override
  Widget build(BuildContext context) {
    return Container(
        height: LeaderboardEntry.height,
        width: Leaderboard.workoutLeaderboardWidth,
        child: StoreConnector<WorkoutVideoScreenState, LeaderboardModel>(
          converter: (store) =>
              store.state.leaderboards[store.state.currentExerciseIndex],
          builder: (context, leaderboard) => Stack(
            children: [
              // Leaderboard position.
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 2,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        (this.isUser
                                ? (leaderboard.leaderboardEntries.length -
                                        leaderboard.userPosition)
                                    .toString()
                                : this.isAbove
                                    ? (leaderboard.leaderboardEntries.length -
                                            leaderboard.userPosition -
                                            1)
                                        .toString()
                                    : (leaderboard.leaderboardEntries.length -
                                            leaderboard.userPosition +
                                            1)
                                        .toString()) +
                            ".",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontSize: fontSize),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3),
                      child: Text(
                        this.isUser
                            ? leaderboard.userEntry.user.username
                            : this.isAbove
                                ? leaderboard.getAbove()?.user?.username
                                : leaderboard.getBelow()?.user?.username,
                        style: TextStyle(
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize),
                      ),
                    ),
                  ],
                ),
              ),

              // Score value.
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  width: SizeConfig.blockSizeHorizontal * 4,
                  child: Text(
                    this.isUser
                        ? leaderboard.getUserEntry.score.getValue.toString()
                        : this.isAbove
                            ? leaderboard.getAbove().score.getValue.toString()
                            : leaderboard.getBelow().score.getValue.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: ColorConstants.launchpadPrimaryWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
