import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/widgets/workout_view/metrics/exercise_leaderboard/exercise_leaderboard_entry_model.dart';

import 'exercise_leaderboard_model.dart';

class ExerciseLeaderboardEntry extends StatefulWidget {
  final ExerciseLeaderboardEntryModel exerciseLeaderboardEntryModel;
  // Is this the user or a launchpad leaderboard entry?
  final bool isUser;
  // Is this the launchpad leaderboard entry one spot above the user?
  final bool isAbove;
  // Is this the launchpad leaderboard entry one spot below the user?
  final bool isBelow;

  static const double height = 40;

  ExerciseLeaderboardEntry(
      {this.exerciseLeaderboardEntryModel,
      this.isUser = false,
      this.isAbove = false,
      this.isBelow = false});
  @override
  _ExerciseLeaderboardEntryState createState() =>
      _ExerciseLeaderboardEntryState(
          exerciseLeaderboardEntryModel: this.exerciseLeaderboardEntryModel,
          isAbove: this.isAbove,
          isBelow: this.isBelow,
          isUser: this.isUser);
}

class _ExerciseLeaderboardEntryState extends State<ExerciseLeaderboardEntry> {
  ExerciseLeaderboardEntryModel exerciseLeaderboardEntryModel;
  int offset;
  final bool isUser;
  final bool isAbove;
  final bool isBelow;

  _ExerciseLeaderboardEntryState(
      {this.exerciseLeaderboardEntryModel,
      this.isUser,
      this.isAbove,
      this.isBelow});

  static const double textPadding = 30;
  static const double fontSize = 16;


  // Consumes -> ExerciseLeaderboardModel (from ExerciseLeaderboard)
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ExerciseLeaderboardEntry.height,
        child: Consumer<ExerciseLeaderboardModel>(
          builder: (context, leaderboard, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leaderboard position.
              Container(
                padding: EdgeInsets.only(left: textPadding),
                child: Text(
                  this.isUser
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
                              .toString(),
                  style: TextStyle(
                      color: ColorConstants.launchpadPrimaryWhite,
                      fontSize: fontSize),
                ),
              ),
              // Username.
              Text(
                this.isUser
                    ? leaderboard.userEntry.user.username
                    : this.isAbove
                        ? leaderboard.getAbove()?.user?.username
                        : leaderboard.getBelow()?.user?.username,
                style: TextStyle(
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontSize: fontSize),
              ),
              // Score value.
              Container(
                padding: EdgeInsets.only(right: textPadding),
                child: Text(
                  this.isUser
                      ? this
                          .exerciseLeaderboardEntryModel
                          .score
                          .getValue
                          .toString()
                      : this.isAbove
                          ? leaderboard.getAbove().score.getValue.toString()
                          : leaderboard.getBelow().score.getValue.toString(),
                  style: TextStyle(
                      color: ColorConstants.launchpadPrimaryWhite,
                      fontSize: fontSize),
                ),
              ),
            ],
          ),
        ));
  }
}
