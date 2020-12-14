import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';
import 'package:video_player/video_player.dart';
import '../workout_video_screen_state.dart';
import 'post_workout_survey_response_box.dart';

class PostWorkoutSurvey extends StatefulWidget {
  final WorkoutVideoScreenState workoutVideoScreenState;
  // Video Player Controller to dispose of before returning to main menu.
  final VideoPlayerController controller;
  PostWorkoutSurvey(this.workoutVideoScreenState, this.controller);
  @override
  _PostWorkoutSurveyState createState() => _PostWorkoutSurveyState();
}

class _PostWorkoutSurveyState extends State<PostWorkoutSurvey> {
  // Workouts to show on homepage
  List<WorkoutMetadata> workouts;
  // Has data been loaded from DB yet?
  bool initialDataLoadDone = false;

  // Retrieve workouts to surface on homepage from DB.
  retrieveWorkouts() async {
    // print('\n\n\n\nTESTTESTTEST\n\n\n\n');
    var url = 'https://launchpad-demo.herokuapp.com/getAllWorkouts';
    var response = await http.get(url);
    // Parse result into a List of JSON in Map<string, dynamic> form.
    print(response.body);
    List<dynamic> allWorkoutsAsString = jsonDecode(response.body);
    List<WorkoutMetadata> list = [];
    allWorkoutsAsString.forEach((json) {
      // Convert Map<string, dynamic> to WorkoutDetails class
      WorkoutMetadata workoutDetails = WorkoutMetadata.fromJson(json);
      print(workoutDetails.workoutDetails.title);
      list.add(workoutDetails);
    });
    // Save workouts to class variable.
    workouts = list;
    setState(() {
      // Let Flutter know DB is done loading to show homepage.
      initialDataLoadDone = true;
    });
    // print("AlternativeWorkouts.length" + workouts.length.toString());
  }

  _PostWorkoutSurveyState() {
    retrieveWorkouts();
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
          _finishWorkoutButton(),
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

  Widget _finishWorkoutButton() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 15,
      right: SizeConfig.blockSizeHorizontal * 4,
      child: FlatButton(
        onPressed: () async {
          if (initialDataLoadDone) {
            Navigator.pushReplacementNamed(context, HomePageScreen.routeName,
                arguments: HomePageScreenState(
                    recommendedClass: workouts[0],
                    sidebarClass: workouts[0],
                    alternativeClasses: workouts));
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
