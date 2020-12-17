import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_model.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';
import 'package:video_player/video_player.dart';
import '../workout_video_screen_state.dart';
import 'post_workout_survey_response_box.dart';

class PostWorkoutSurvey extends StatelessWidget {
  final WorkoutVideoScreenState workoutVideoScreenState;
  // Video Player Controller to dispose of before returning to main menu.
  final VideoPlayerController controller;

  final HomePageScreenModel model = HomePageScreenModel();

  PostWorkoutSurvey(this.workoutVideoScreenState, this.controller) {
    HomePageScreenModel.retrieveWorkouts().then((response) {
      model.initialDataLoadDone = true;
      model.workouts = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          _surveyLabel(),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 4,
            bottom: SizeConfig.blockSizeVertical * 15,
            child: PostWorkoutSurveyResponseBox(),
          ),
          _finishWorkoutButton(context),
        ],
      ),
      color: ColorConstants.launchpadPrimaryBlue,
    );
  }

  Widget _surveyLabel() {
    return Positioned(
      left: SizeConfig.blockSizeHorizontal * 4,
      top: SizeConfig.blockSizeVertical * 15,
      child: Text(
        "Please rate your workout for an extra 100 points",
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.blockSizeHorizontal * 2.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _finishWorkoutButton(BuildContext context) {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 15,
      right: SizeConfig.blockSizeHorizontal * 4,
      child: FlatButton(
        onPressed: () async {
          if (model.initialDataLoadDone) {
            Navigator.pushReplacementNamed(context, HomePageScreen.routeName,
                arguments: HomePageScreenState(
                    recommendedClass: model.workouts[0],
                    sidebarClass: model.workouts[0],
                    alternativeClasses: model.workouts));
          }
        },
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 25,
          height: SizeConfig.blockSizeVertical * 8,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
            color: ColorConstants.launchpadPlayButtonBlue,
          ),
          child: Center(
            child: Text(
              "Finish",
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
