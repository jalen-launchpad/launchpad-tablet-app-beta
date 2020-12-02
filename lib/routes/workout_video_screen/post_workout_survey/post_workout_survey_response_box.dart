import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

import '../workout_video_screen_state.dart';
import 'post_workout_survey_repsonse_box_row.dart';

class PostWorkoutSurveyResponseBox extends StatefulWidget {
  @override
  _PostWorkoutSurveyResponseBoxState createState() =>
      _PostWorkoutSurveyResponseBoxState();
}

class _PostWorkoutSurveyResponseBoxState
    extends State<PostWorkoutSurveyResponseBox> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WorkoutVideoScreenState>(
      builder: (context, store) => Container(
        width: SizeConfig.blockSizeHorizontal * 62,
        height: SizeConfig.blockSizeVertical * 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.blockSizeHorizontal * 0.5,
          ),
          color: ColorConstants.launchpadPrimaryBlack,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PostWorkoutSurveyResponseBoxRow(store, "Overall"),
            PostWorkoutSurveyResponseBoxRow(store, "Instructor"),
            PostWorkoutSurveyResponseBoxRow(store, "Fun"),
            PostWorkoutSurveyResponseBoxRow(store, "Difficulty"),
          ],
        ),
      ),
    );
  }
}
