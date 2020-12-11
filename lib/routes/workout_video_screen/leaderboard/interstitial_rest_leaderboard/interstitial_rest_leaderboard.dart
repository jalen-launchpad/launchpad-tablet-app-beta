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
        Container(width: SizeConfig.blockSizeHorizontal * 4),
        Container(
            width: Leaderboard.workoutLeaderboardWidth,
            height: Leaderboard.workoutLeaderboardHeight,
            decoration: BoxDecoration(
              color: ColorConstants.launchpadPrimaryBlack,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: StoreBuilder<WorkoutVideoScreenState>(
                builder: (context, store) {
              return Stack(
                children: [
                  Positioned(
                    top: SizeConfig.blockSizeVertical * 3,
                    child: Container(
                      child: Center(
                        child: Text(
                          "Overall",
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
                  Positioned(
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
                  ),
                  Positioned(
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
                  ),
                  Positioned(
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
                    ),
                  )
                ],
              );
            }))
      ],
    );
  }
}
