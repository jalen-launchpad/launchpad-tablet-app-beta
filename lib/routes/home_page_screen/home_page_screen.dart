import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/home_page_screen/selected_class_sidebar/selected_class_sidebar.dart';

import 'class_preview.dart';
import 'workout_card/workout_card.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 67,
              child: ListView(children: [
                Container(
                  child: ClassPreview(),
                  height: SizeConfig.blockSizeVertical * 80,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    top: SizeConfig.blockSizeVertical * 5,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Text("Other Workout Options",
                      style: TextStyle(
                          color: ColorConstants.launchpadPrimaryWhite,
                          fontSize: 16)),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutCard(),
                      WorkoutCard(),
                      WorkoutCard(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutCard(),
                      WorkoutCard(),
                      WorkoutCard(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutCard(),
                      WorkoutCard(),
                      WorkoutCard(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutCard(),
                      WorkoutCard(),
                      WorkoutCard(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutCard(),
                      WorkoutCard(),
                      WorkoutCard(),
                    ],
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: SelectedClassSidebar(),
                width: SizeConfig.blockSizeHorizontal * 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
