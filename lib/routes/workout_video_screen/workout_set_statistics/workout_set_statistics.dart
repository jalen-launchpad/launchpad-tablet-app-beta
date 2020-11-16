import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import 'workout_set_statistics_bar.dart';

class WorkoutSetStatistics extends StatelessWidget {
  static double maxBarHeight = SizeConfig.blockSizeVertical * 20;
  final String exerciseName;
  static double height = SizeConfig.blockSizeVertical * 35;
  WorkoutSetStatistics(this.exerciseName);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WorkoutVideoScreenState>(
      builder: (context, store) => Container(
        width: SizeConfig.blockSizeHorizontal * 38,
        height: SizeConfig.blockSizeVertical * 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.blockSizeHorizontal * 0.5,
          ),
          color: Colors.black,
        ),
        child: Stack(children: [
          Positioned(
              top: SizeConfig.blockSizeVertical * 2,
              left: SizeConfig.blockSizeHorizontal * 2,
              child: Text(
                this.exerciseName,
                style: TextStyle(
                  color: ColorConstants.launchpadPrimaryWhite,
                  fontSize: SizeConfig.blockSizeHorizontal * 2,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Container(
            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WorkoutSetStatisticsBar(
                    store.state.previousUserLeaderboardEntry.score.value,
                    "You",
                    max(store.state.previousUserLeaderboardEntry.score.value,
                        24)),
                WorkoutSetStatisticsBar(2, "16 YO", 24),
                WorkoutSetStatisticsBar(24, "Pros", 24),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
