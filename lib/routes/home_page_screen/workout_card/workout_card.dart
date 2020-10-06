import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/enums/mods_enum.dart';
import 'package:tabletapp/routes/home_page_screen/workout_card/mods_indicator.dart';

class WorkoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // **************
        // Background Image
        // **************
        children: [
          Image.asset(
            'assets/images/workoutCardImagePlaceholder.png',
            height: SizeConfig.blockSizeVertical * 18,
            width: SizeConfig.blockSizeHorizontal * 19.85,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 18,
            width: SizeConfig.blockSizeHorizontal * 19.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                4,
              ),
              color:
                  ColorConstants.launchpadSecondaryDarkBlue.withOpacity(0.85),
            ),
          ),

          // **************
          // Workout Mods
          // **************
          Positioned(
            left: SizeConfig.blockSizeHorizontal,
            top: SizeConfig.blockSizeVertical * 1.5,
            child: ModsInidcator(
              [
                ModsEnum.plio,
                ModsEnum.physio,
              ],
            ),
          ),

          // **************
          // Workout Duration
          // **************
          Positioned(
            right: SizeConfig.blockSizeHorizontal,
            top: SizeConfig.blockSizeVertical * 1.5,
            child: Container(
              height: SizeConfig.blockSizeVertical * 3,
              width: SizeConfig.blockSizeHorizontal * 5,
              decoration: BoxDecoration(
                color: ColorConstants.launchpadPrimaryBlue,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 0.5),
                    child: Text(
                      "20",
                      style: TextStyle(
                        color: ColorConstants.launchpadPrimaryWhite,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/smallTimeVector.png',
                    height: SizeConfig.blockSizeHorizontal,
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ],
              ),
            ),
          ),
          // **************
          // Workout Title
          // **************
          Positioned(
            left: SizeConfig.blockSizeHorizontal,
            right: SizeConfig.blockSizeHorizontal,
            bottom: SizeConfig.blockSizeVertical,
            child: Container(
              child: Text(
                "Lowerbody Cooldown",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorConstants.launchpadPrimaryWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
