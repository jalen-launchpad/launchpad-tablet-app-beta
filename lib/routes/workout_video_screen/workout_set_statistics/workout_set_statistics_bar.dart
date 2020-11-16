import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

import 'workout_set_statistics.dart';

class WorkoutSetStatisticsBar extends StatelessWidget {
  final int score;
  final String demographic;
  final int highScoreAcrossDemographics;

  WorkoutSetStatisticsBar(
      this.score, this.demographic, this.highScoreAcrossDemographics);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.score.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: (this.score / this.highScoreAcrossDemographics) *
                WorkoutSetStatistics.maxBarHeight,
            width: SizeConfig.blockSizeHorizontal * 3,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
              color: ColorConstants.workoutStatisticsBarGreen,
            ),
            margin: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical,
            ),
          ),
          Text(
            this.demographic,
            style: TextStyle(
              color: ColorConstants.launchpadPrimaryWhite,
            ),
          ),
        ],
      ),
    );
  }
}
