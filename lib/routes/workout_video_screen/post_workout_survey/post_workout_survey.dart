import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

import '../workout_video_screen_state.dart';
import 'post_workout_survey_response_box.dart';

class PostWorkoutSurvey extends StatefulWidget {
  final WorkoutVideoScreenState workoutVideoScreenState;

  PostWorkoutSurvey(this.workoutVideoScreenState);
  @override
  _PostWorkoutSurveyState createState() =>
      _PostWorkoutSurveyState(this.workoutVideoScreenState);
}

class _PostWorkoutSurveyState extends State<PostWorkoutSurvey> {
  final WorkoutVideoScreenState workoutVideoScreenState;

  _PostWorkoutSurveyState(this.workoutVideoScreenState);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
            child: Text(
              "Please rate your workout for an extra 100 points",
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PostWorkoutSurveyResponseBox(
            
          )
        ],
      ),
      color: ColorConstants.launchpadPrimaryBlue,
    );
  }
}
