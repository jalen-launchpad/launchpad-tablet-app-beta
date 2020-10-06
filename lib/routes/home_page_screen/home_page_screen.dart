import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
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
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 3,
              child: ListView(children: [
                Container(
                  child: ClassPreview(),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 20,
                    bottom: 45,
                  ),
                  child: Text("Other Workout Options",
                      style: TextStyle(
                          color: ColorConstants.launchpadPrimaryWhite,
                          fontSize: 16)),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 45,
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
                    left: 30,
                    right: 30,
                    bottom: 45,
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
                    left: 30,
                    right: 30,
                    bottom: 45,
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
                    left: 30,
                    right: 30,
                    bottom: 45,
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
                    left: 30,
                    right: 30,
                    bottom: 45,
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
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
