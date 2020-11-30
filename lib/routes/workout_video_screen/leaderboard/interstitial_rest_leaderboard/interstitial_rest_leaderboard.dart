import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import '../leaderboard.dart';
import '../leaderboard_entry.dart';
import 'interstitial_rest_leaderboard_entry.dart';

// @params
// User user
// List<InterstitialRestLeaderboardEntryModel> currentLeaderboards
class InterstitialRestLeaderboard extends StatefulWidget {
  static double workoutLeaderboardHeight = SizeConfig.blockSizeVertical * 70;
  static double workoutLeaderboardWidth = SizeConfig.blockSizeHorizontal * 25;

  static double borderRadius = SizeConfig.blockSizeHorizontal * 3;
  @override
  _InterstitialRestLeaderboardState createState() =>
      _InterstitialRestLeaderboardState();
}

class _InterstitialRestLeaderboardState
    extends State<InterstitialRestLeaderboard> {
  static double borderRadius = SizeConfig.blockSizeHorizontal * 3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Leaderboard(),
        /* Container(
            width: Leaderboard.workoutLeaderboardHeight,
            height: Leaderboard.workoutLeaderboardHeight,
            decoration: BoxDecoration(
              color: ColorConstants.launchpadPrimaryWhite,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ))*/
      ],
    );
  }
}
