import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'leaderboard_entry.dart';

// @params
// User user
// List<LeaderboardEntryModel> currentLeaderboards
class Leaderboard extends StatelessWidget {
  static double workoutLeaderboardHeight = SizeConfig.blockSizeVertical * 74;
  static double workoutLeaderboardWidth = SizeConfig.blockSizeHorizontal * 25;
  static double borderRadius = SizeConfig.blockSizeHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Leaderboard.workoutLeaderboardWidth,
        height: Leaderboard.workoutLeaderboardHeight,
        decoration: BoxDecoration(
          color: ColorConstants.launchpadPrimaryBlack,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            _leaderboardLabel(),
            _topThree(),
            _whiteLineDivider(),
            _nearestFive(),
          ],
        ));
  }

  Widget _leaderboardLabel() {
    return StoreConnector<WorkoutVideoScreenState, bool>(
      converter: (store) => store.state.currentExercise.isRest,
      builder: (context, isRest) => Positioned(
        top: SizeConfig.blockSizeVertical * 3,
        child: Container(
          child: Center(
            child: Text(
              isRest ? "Previous Set" : "Current Set",
              style: TextStyle(
                color: ColorConstants.launchpadPrimaryWhite,
                fontSize: SizeConfig.blockSizeHorizontal * 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          width: Leaderboard.workoutLeaderboardWidth,
        ),
      ),
    );
  }

  Widget _topThree() {
    return Positioned(
      top: SizeConfig.blockSizeVertical * 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
          color: Colors.black,
        ),
        height: Leaderboard.workoutLeaderboardHeight / 4,
        width: Leaderboard.workoutLeaderboardWidth,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          LeaderboardEntry(
            topThree: true,
            nearestFive: false,
            position: 0,
          ),
          LeaderboardEntry(
            topThree: true,
            nearestFive: false,
            position: 1,
          ),
          LeaderboardEntry(
            topThree: true,
            nearestFive: false,
            position: 2,
          ),
        ]),
      ),
    );
  }

  Widget _whiteLineDivider() {
    return Positioned(
      top: SizeConfig.blockSizeVertical * 27,
      child: Container(
          height: SizeConfig.blockSizeVertical * 3,
          width: Leaderboard.workoutLeaderboardWidth,
          child: Center(
            child: Container(
              height: SizeConfig.blockSizeVertical * 0.25,
              width: Leaderboard.workoutLeaderboardWidth -
                  SizeConfig.blockSizeHorizontal * 3,
              color: ColorConstants.launchpadPrimaryWhite,
            ),
          )),
    );
  }

  Widget _nearestFive() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        height: (2 * Leaderboard.workoutLeaderboardHeight / 4),
        width: Leaderboard.workoutLeaderboardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LeaderboardEntry(
              topThree: false,
              nearestFive: true,
              position: 0,
            ),
            LeaderboardEntry(
              topThree: false,
              nearestFive: true,
              position: 1,
            ),
            LeaderboardEntry(
              topThree: false,
              nearestFive: true,
              position: 2,
            ),
            LeaderboardEntry(
              topThree: false,
              nearestFive: true,
              position: 3,
            ),
            LeaderboardEntry(
              topThree: false,
              nearestFive: true,
              position: 4,
            ),
          ],
        ),
      ),
    );
  }
}
