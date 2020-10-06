import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
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
            height: 125,
            width: 218.75,
          ),
          Container(
            height: 125,
            width: 218.75,
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
            left: 10,
            top: 10,
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
            right: 10,
            top: 10,
            child: Container(
              height: 20,
              width: 60,
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
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      "20",
                      style: TextStyle(
                        color: ColorConstants.launchpadPrimaryWhite,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/smallTimeVector.png',
                    height: 13,
                    width: 13,
                  ),
                ],
              ),
            ),
          ),
          // **************
          // Workout Title
          // **************
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
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
