import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/exercise_model.dart';

import '../constants.dart';

class ExerciseBucket extends StatelessWidget {
  final List<ExerciseModel> distinctExerciseList;
  ExerciseBucket(this.distinctExerciseList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  "Exercises",
                  style: TextStyle(
                    fontSize: SelectedClassSidebarConstants.subTextSize,
                    color: ColorConstants.launchpadPrimaryWhite,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: SelectedClassSidebarConstants.workoutInformationBucketHeight,
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
                    padding:
                        EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                    child: Image.asset(
                      'assets/images/exerciseCountVector.png',
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
                      distinctExerciseList.length.toString() + " exe",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 2,
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
