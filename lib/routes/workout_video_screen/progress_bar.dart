import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/constants.dart';

class ProgressBar extends StatefulWidget {
  final double duration;
  ProgressBar(this.duration);

  @override
  _ProgressBarState createState() => _ProgressBarState(this.duration);
}

class _ProgressBarState extends State<ProgressBar> {
  final double duration;
  double secondsElapsed = 0;
  Timer progress;

  void pause() {
    progress.cancel();
  }

  void play() {
    initiateProgressBar();
  }

  void initiateProgressBar() {
    progress = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsElapsed < duration) {
        setState(() {
          secondsElapsed++;
        });
      }
    });
  }

  _ProgressBarState(this.duration) {
    initiateProgressBar();
  }

  @override
  Widget build(BuildContext context) {
    Alignment progressLocation =
        Alignment(-1.0 + (2 * secondsElapsed / duration), 0.0);

    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 4,
          left: WorkoutVideoScreenConstants.leftPaddingAlign),
      height: SizeConfig.blockSizeVertical * 3.5,
      width: SizeConfig.blockSizeHorizontal * 85.25,
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: SizeConfig.blockSizeVertical,
                width: SizeConfig.blockSizeHorizontal * 85,
                color: ColorConstants.workoutVideoProgressBarGrey,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: SizeConfig.blockSizeVertical,
                width: (SizeConfig.blockSizeHorizontal *
                    85 *
                    (secondsElapsed / duration)),
                color: ColorConstants.workoutVideoProgressBarBlue,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorConstants.workoutVideoProgressBarBlue),
                height: SizeConfig.blockSizeHorizontal,
                width: SizeConfig.blockSizeHorizontal,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorConstants.workoutVideoProgressBarGrey),
                height: SizeConfig.blockSizeHorizontal,
                width: SizeConfig.blockSizeHorizontal,
              ),
            ),
            Align(
              alignment: progressLocation,
              child: Container(
                height: SizeConfig.blockSizeVertical * 3,
                width: SizeConfig.blockSizeVertical * 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.workoutVideoProgressBarBlue,
                        borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 3,
                        ),
                      ),
                      height: SizeConfig.blockSizeVertical * 3,
                      width: SizeConfig.blockSizeVertical * 3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: SizeConfig.blockSizeVertical * 1.5,
                          width: SizeConfig.blockSizeVertical * 1.5,
                          decoration: BoxDecoration(
                              color: ColorConstants.launchpadPrimaryWhite,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeVertical * 1.5))),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
