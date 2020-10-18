import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/enums/mods_enum.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_actions.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';
import 'package:tabletapp/routes/home_page_screen/workout_card/mods_indicator.dart';
import 'package:redux/redux.dart';

class WorkoutCard extends StatelessWidget {
  final Store<HomePageScreenState> store;
  final WorkoutMetadata workoutMetadata;
  WorkoutCard(this.store, this.workoutMetadata);

  static double width = SizeConfig.blockSizeHorizontal * 19.85;
  static double height = SizeConfig.blockSizeHorizontal * 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        // Flat Button automatically adds padding.
        padding: EdgeInsets.all(0),
        onPressed: () {
          print("button pressed");
          store.dispatch(
              UpdateSidebarClassAction(workoutMetadata: workoutMetadata));
        },
        child: Container(
          child: Stack(
            // **************
            // Background Image
            // **************
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 19.85,
                height: SizeConfig.blockSizeVertical * 18,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/images/workoutCardImagePlaceholder.png',
                  ),
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 18,
                width: SizeConfig.blockSizeHorizontal * 19.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                  color: ColorConstants.launchpadSecondaryDarkBlue
                      .withOpacity(0.85),
                ),
              ),

              // **************
              // Workout Mods
              // **************
              Positioned(
                left: SizeConfig.blockSizeHorizontal,
                top: SizeConfig.blockSizeVertical * 1.5,
                child: ModsInidcator(
                  workoutMetadata.workoutDetails.modsList,
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
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 0.5),
                        child: Text(
                          workoutMetadata.workoutDetails.duration.toInt().toString(),
                          style: TextStyle(
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontSize: SizeConfig.blockSizeHorizontal * 1.2,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/smallTimeVector.png',
                        height: SizeConfig.blockSizeHorizontal * 1.2,
                        width: SizeConfig.blockSizeHorizontal * 1.2,
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
                    workoutMetadata.workoutDetails.title,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 1.4,
                      color: ColorConstants.launchpadPrimaryWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
