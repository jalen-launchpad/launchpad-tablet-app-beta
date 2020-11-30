import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

class StandardRepCounter extends StatelessWidget {
  static double widgetWidth = SizeConfig.blockSizeHorizontal * 30;
  static double widgetHeight = SizeConfig.blockSizeVertical * 35;

  static double mainCircleHeightWidth = SizeConfig.blockSizeHorizontal * 18;
  static double mainFontSize = SizeConfig.blockSizeHorizontal * 6;
  static double secondaryFontSize = SizeConfig.blockSizeHorizontal * 3;

  static const double secondaryFontOpacity = 0.6;

  static double goodRepLeftPosition =
      mainCircleHeightWidth + SizeConfig.blockSizeHorizontal;
  static double goodRepTopPosition = SizeConfig.blockSizeVertical * 3;
  static double badRepBottomPosition = SizeConfig.blockSizeVertical * 0.5;
  static double badRepLeftPosition =
      mainCircleHeightWidth - SizeConfig.blockSizeHorizontal * 2.5;

  static double secondaryCircleHeightWidth = SizeConfig.blockSizeHorizontal * 7;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      child: StoreBuilder<WorkoutVideoScreenState>(builder: (context, store) {
        var userEntry = store
            .state.leaderboards[store.state.currentExerciseIndex].getUserEntry;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Main Rep Counter
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.launchpadPrimaryBlack,
              ),
              height: mainCircleHeightWidth,
              width: mainCircleHeightWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
                    child: Text(userEntry.score.totalReps.toString(),
                        style: TextStyle(
                          color: ColorConstants.launchpadSecondaryLightBlue,
                          fontSize: mainFontSize,
                          fontWeight: FontWeight.bold,
                          height: 0.3,
                        )),
                  ),
                  Text(
                      store.state.currentExercise.isRest
                          ? "Rest"
                          : store.state.currentExercise.exerciseSetDefinition
                                  .targetReps
                                  .toString() +
                              (store.state.currentExercise.exerciseSetDefinition
                                      .isTime
                                  ? "s"
                                  : ""),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.launchpadPrimaryWhite
                              .withOpacity(secondaryFontOpacity),
                          fontSize: secondaryFontSize)),
                ],
              ),
            ),
/*
            // Good Rep Counter
            Positioned(
              left: goodRepLeftPosition,
              top: goodRepTopPosition,
              child: Container(
                child: Center(
                    child: Text(userEntry.score.goodReps.toString(),
                        style: TextStyle(
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontSize: secondaryFontSize))),
                height: secondaryCircleHeightWidth,
                width: secondaryCircleHeightWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.launchpadGreen,
                ),
              ),
            ),

            Positioned(
              left: badRepLeftPosition,
              bottom: badRepBottomPosition,
              child: Container(
                child: Center(
                    child: Text(userEntry.score.badReps.toString(),
                        style: TextStyle(
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontSize: secondaryFontSize))),
                height: secondaryCircleHeightWidth,
                width: secondaryCircleHeightWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.launchpadRed,
                ),
              ),
            )
            */
          ],
        );
      }),
    );
  }
}
