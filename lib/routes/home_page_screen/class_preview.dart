import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_actions.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';

class ClassPreview extends StatelessWidget {
  final WorkoutMetadata workoutMetadata;
  final Store<HomePageScreenState> store;
  ClassPreview(this.workoutMetadata, this.store);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // *************
          // Bakcground Photo
          // *************
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 67,
              height: SizeConfig.blockSizeVertical * 85,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  "assets/images/backgroundPlaceholder.png",
                ),
              ),
            ),
          ),

          // *************
          // Launchpad Corner Logo
          // *************
          Positioned(
            child: Container(
              height: SizeConfig.blockSizeHorizontal * 2,
              width: SizeConfig.blockSizeVertical * 18,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/homePageLogo.png')),
            ),
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
              child: GestureDetector(
                onTap: () {
                  store.dispatch(UpdateSidebarClassAction(
                      workoutMetadata: workoutMetadata));
                },
                child: Text(
                  workoutMetadata.workoutDetails.title,
                  style: TextStyle(
                    color: ColorConstants.launchpadPrimaryWhite,
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
