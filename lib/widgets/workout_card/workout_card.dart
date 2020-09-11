import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/routes/bluetooth_setup_screen.dart';
import 'package:tabletapp/routes/workout_video_screen.dart';
import 'package:tabletapp/widgets/workout_card/mods_indicator.dart';

// A WorkoutCard is the card that is displayed on the homepage
// representing a Workout.

// @params
// ClassDetails workoutDetails

class WorkoutCard extends StatelessWidget {
  static const EdgeInsets containerPadding = EdgeInsets.fromLTRB(0, 0, 10, 5);

  static const double height = 260;

  static const double width = 220;

  static const double titleFontSize = 28;

  static const double athleteTrainerFontSize = 14;

  static const BorderRadius containerBorderRadius =
      BorderRadius.all(Radius.circular(20));

  static const EdgeInsets bottomMargin = EdgeInsets.only(bottom: 10);

  static const EdgeInsets containerInteriorPadding =
      EdgeInsets.fromLTRB(5, 15, 5, 5);

  static const TextStyle titleTextStyle = TextStyle(
      fontSize: titleFontSize, color: ColorConstants.launchpadPrimaryWhite);

  final WorkoutDetails workoutDetails;

  WorkoutCard(this.workoutDetails);

  @override
  Widget build(BuildContext context) {
    print(this.workoutDetails.title);
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    WorkoutVideoScreen(workoutDetails: this.workoutDetails)));
      },
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: containerBorderRadius,
              color: ColorConstants.launchpadPrimaryBlue),
          padding: containerInteriorPadding,
          child: Column(
            children: [
              Container(
                margin: bottomMargin,
                child: Center(
                  child: Text(
                    this.workoutDetails.title,
                    style: titleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Featuring ${this.workoutDetails.athlete} and ${this.workoutDetails.trainer}",
                  style: TextStyle(
                      fontSize: athleteTrainerFontSize,
                      color: ColorConstants.launchpadPrimaryWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Container(
                  padding: containerPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ModsInidcator(this.workoutDetails.modsList)],
                  ))
            ],
          )),
    );
  }
}
