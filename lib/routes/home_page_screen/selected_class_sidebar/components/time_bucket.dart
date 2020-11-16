import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/workout_details.dart';

import '../constants.dart';

class TimeBucket extends StatelessWidget {
  final WorkoutDetails details;
  TimeBucket(this.details);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: SizeConfig.blockSizeHorizontal * 2.5,
      ),
      child: Column(
        // Text
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical,
            ),
            width: SelectedClassSidebarConstants.timeExerciseBucketWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: SelectedClassSidebarConstants.subTextSize,
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Box
          Container(
            height:
                SelectedClassSidebarConstants.workoutInformationBucketHeight,
            width: SelectedClassSidebarConstants.timeExerciseBucketWidth,
            decoration: BoxDecoration(
              color: ColorConstants.launchpadPrimaryBlack.withOpacity(
                0.3,
              ),
              borderRadius: BorderRadius.circular(
                SelectedClassSidebarConstants.bucketBorderRadius,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    child: Image.asset(
                      'assets/images/timeVector.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    child: Text(
                      (details.duration ~/ 60).toString() + " min",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 2,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.launchpadPrimaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
