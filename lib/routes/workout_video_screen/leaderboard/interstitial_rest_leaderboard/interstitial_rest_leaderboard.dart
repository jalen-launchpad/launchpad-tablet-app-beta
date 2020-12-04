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
// List<InterstitialRestInterstitialRestLeaderboardEntryModel> currentLeaderboards
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
  static double borderRadius = SizeConfig.blockSizeHorizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Leaderboard(),
        Container(
            width: Leaderboard.workoutLeaderboardWidth,
            height: Leaderboard.workoutLeaderboardHeight,
            decoration: BoxDecoration(
              color: ColorConstants.launchpadPrimaryWhite,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: StoreBuilder<WorkoutVideoScreenState>(
                builder: (context, store) {
               return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius),
                      ),
                      color: Colors.black,
                    ),
                    height: Leaderboard.workoutLeaderboardHeight / 3 - 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InterstitialRestLeaderboardEntry(
                            topThree: true,
                            nearestFive: false,
                            position: 0,
                          ),
                          InterstitialRestLeaderboardEntry(
                            topThree: true,
                            nearestFive: false,
                            position: 1,
                          ),
                          InterstitialRestLeaderboardEntry(
                            topThree: true,
                            nearestFive: false,
                            position: 2,
                          ),
                        ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius),
                      ),
                      color: Colors.black,
                    ),
                    height: (2 * Leaderboard.workoutLeaderboardHeight / 3) - 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InterstitialRestLeaderboardEntry(
                          topThree: false,
                          nearestFive: true,
                          position: 0,
                        ),
                        InterstitialRestLeaderboardEntry(
                          topThree: false,
                          nearestFive: true,
                          position: 1,
                        ),
                        InterstitialRestLeaderboardEntry(
                          topThree: false,
                          nearestFive: true,
                          position: 2,
                        ),
                        InterstitialRestLeaderboardEntry(
                          topThree: false,
                          nearestFive: true,
                          position: 3,
                        ),
                        InterstitialRestLeaderboardEntry(
                          topThree: false,
                          nearestFive: true,
                          position: 4,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }))
      ],
    );
  }
}
