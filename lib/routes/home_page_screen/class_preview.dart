import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/workout_details.dart';

class ClassPreview extends StatelessWidget {
  final WorkoutDetails workoutDetails;
  ClassPreview(this.workoutDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
  
      child: Stack(
        children: [
          // TODO(jalen): Add background image here

          // *************
          // Bakcground Photo
          // *************
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/backgroundPlaceholder.png",
              width: SizeConfig.blockSizeHorizontal * 67,
            ),
          ),

          // *************
          // Launchpad Corner Logo
          // *************
          Positioned(
            child: Image.asset('assets/images/homePageLogo.png', height: 25),
            left: SizeConfig.blockSizeHorizontal * 3,
            top: SizeConfig.blockSizeVertical * 6,
          ),

          // *************
          // Black gradient effect from bottom of screen.
          // *************
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  width: SizeConfig.blockSizeHorizontal * 67,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [
                        ColorConstants.launchpadPrimaryBlack,
                        ColorConstants.launchpadPrimaryBlack.withOpacity(0)
                      ], // Blueish to Opaque
                    ),
                  ),
                ),
              ],
            ),
          ),

          // *************
          // Class Preview Title
          // *************
          Positioned(
            bottom: SizeConfig.blockSizeVertical * 5,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 67,
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeHorizontal * 3,
              ),
              child: Text(
                // TODO(jalen): Replace with real class preview value
                workoutDetails.title,
                style: TextStyle(
                  color: ColorConstants.launchpadPrimaryWhite,
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
