import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';

class RepCounter extends StatefulWidget {
  final ExerciseScoreModel exerciseScore;

  RepCounter({this.exerciseScore});
  @override
  _RepCounterState createState() => _RepCounterState();
}


// Consumes -> LeaderboardEntryModel
class _RepCounterState extends State<RepCounter> {
  static const double widgetWidth = 250;
  static const double widgetHeight = 220;

  static const double mainCircleHeightWidth = 150;
  static const double mainFontSize = 54;
  static const double secondaryFontSize = 30;

  static const double secondaryFontOpacity = 0.6;

  static const double goodRepLeftPosition = 155;
  static const double goodRepTopPosition = 30;
  static const double badRepBottomPosition = 15;
  static const double badRepLeftPosition = 105;

  static const double secondaryCircleHeightWidth = 70;
  static const double secondaryCircleBorderRadius = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      child: Consumer<LeaderboardEntryModel>(
          builder: (context, entry, child) {
        return Stack(
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
                    padding: EdgeInsets.only(top: 50),
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
        );
      }),
    );
  }
}
