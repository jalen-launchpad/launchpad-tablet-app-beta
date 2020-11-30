import 'package:flutter/material.dart';
import 'package:tabletapp/constants/size_config.dart';

class PostWorkoutSurveyResponseBox extends StatefulWidget {
  @override
  _PostWorkoutSurveyResponseBoxState createState() =>
      _PostWorkoutSurveyResponseBoxState();
}

class _PostWorkoutSurveyResponseBoxState
    extends State<PostWorkoutSurveyResponseBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 60,
      height: SizeConfig.blockSizeVertical * 30,
    );
  }
}
