import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/routes/workout_video_screen/leaderboard/leaderboard_entry_model.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

class RepCounter extends StatefulWidget {
  final ExerciseScoreModel exerciseScore;

  RepCounter({this.exerciseScore});
  @override
  _RepCounterState createState() => _RepCounterState();
}

// Consumes -> LeaderboardEntryModel
class _RepCounterState extends State<RepCounter> {
  static double widgetWidth = SizeConfig.blockSizeHorizontal * 25;
  static double widgetHeight = SizeConfig.blockSizeVertical * 35;

  static double mainCircleHeightWidth = SizeConfig.blockSizeHorizontal * 15;
  static double mainFontSize = SizeConfig.blockSizeHorizontal * 7;
  static double secondaryFontSize = SizeConfig.blockSizeHorizontal * 4;

  static const double secondaryFontOpacity = 0.6;

  static double goodRepLeftPosition = mainCircleHeightWidth + SizeConfig.blockSizeHorizontal;
  static double goodRepTopPosition = SizeConfig.blockSizeVertical * 3;
  static double badRepBottomPosition = SizeConfig.blockSizeVertical * 0.5;
  static double badRepLeftPosition = mainCircleHeightWidth - SizeConfig.blockSizeHorizontal * 2.5;

  static double secondaryCircleHeightWidth = SizeConfig.blockSizeHorizontal * 7;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      child: StoreConnector<WorkoutVideoScreenState, LeaderboardEntryModel>(
        converter: (store) => store
            .state.leaderboards[store.state.currentExerciseIndex].userEntry,
        builder: (context, entry) => Stack(
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
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
                    child: Text(entry.score.totalReps.toString(),
                        style: TextStyle(
                          color: ColorConstants.launchpadSecondaryLightBlue,
                          fontSize: mainFontSize,
                          height: 0.3,
                        )),
                  ),
                  Text(entry.exerciseSetDefinition.targetReps.toString(),
                      style: TextStyle(
                          color: ColorConstants.launchpadPrimaryWhite
                              .withOpacity(secondaryFontOpacity),
                          fontSize: secondaryFontSize)),
                ],
              ),
            ),

            // Good Rep Counter
            Positioned(
              left: goodRepLeftPosition,
              top: goodRepTopPosition,
              child: Container(
                child: Center(
                    child: Text(entry.score.goodReps.toString(),
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
                    child: Text(entry.score.badReps.toString(),
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
          ],
        ),
      ),
    );
  }
}
