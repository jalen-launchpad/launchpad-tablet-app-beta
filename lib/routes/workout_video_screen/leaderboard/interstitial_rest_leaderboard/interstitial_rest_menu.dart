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
// List<InterstitialRestInterstitialRestInterstitialRestLeaderboardEntryModel> currentLeaderboards
class InterstitialRestLeaderboard extends StatefulWidget {
  @override
  _InterstitialRestLeaderboardState createState() =>
      _InterstitialRestLeaderboardState();
}

class _InterstitialRestLeaderboardState
    extends State<InterstitialRestLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Leaderboard(),
          Container(width: SizeConfig.blockSizeHorizontal * 4),
          InterstitialRestLeaderboard(),
        ],
      ),
    );
  }
}
