import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/routes/home_page_screen/selected_class_sidebar/exercise_preview_card.dart';

import 'intensity_graph.dart';

class SelectedClassSidebar extends StatefulWidget {
  @override
  _SelectedClassSidebarState createState() => _SelectedClassSidebarState();
}

class _SelectedClassSidebarState extends State<SelectedClassSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.launchpadPrimaryBlue,
      padding: EdgeInsets.only(
        left: 30,
      ),
      child: Column(
        children: [
          // ************
          // Calendar, Today's Workout Text and Settings Logo
          // ************
          Container(
            padding: EdgeInsets.only(
              top: 25,
            ),
            child: Row(
              children: [
                Container(
                  child: Image.asset('assets/images/calendarVector.png',
                      height: 20),
                ),
                Container(
                  child: Text(
                    "Today's Workout",
                    style: TextStyle(
                        color: ColorConstants.launchpadMenuSecondaryBlue,
                        fontSize: 20,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
              ],
            ),
          ),
          // ************
          // Workout Title
          // ************
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Shoulder Blast",
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 35,
                      color: ColorConstants.launchpadPrimaryWhite,
                    )),
              ],
            ),
            padding: EdgeInsets.only(
              top: 15,
            ),
          ),
          // ************
          // Workout Details label
          // ************
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Workout Details",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 20,
                    color: ColorConstants.launchpadPrimaryWhite,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.only(
              top: 15,
            ),
          ),
          // ************
          // Workout Details Scrollview
          // ************
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                right: 15,
              ),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) =>
                  ExercisePreviewCard(),
              separatorBuilder: (BuildContext context, int index) => Divider(
                indent: 0,
                endIndent: 20,
              ),
            ),
          ),

          // ************
          // Exercise and Time Buckets
          // ************
          Container(
            padding: EdgeInsets.only(
              top: 25,
              right: 30,
            ),
            child: Row(
              children: [
                // ************
                // Time Bucket
                // ************
                Container(
                  margin: EdgeInsets.only(
                    right: 25,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.launchpadPrimaryWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                            color: ColorConstants.launchpadPrimaryBlack
                                .withOpacity(
                              0.3,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/timeVector.png',
                                  height: 25,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Text(
                                    "50 min",
                                    style: TextStyle(
                                      fontSize: 26,
                                      color:
                                          ColorConstants.launchpadPrimaryWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                // ************
                // Time Bucket
                // ************
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Exercises",
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.launchpadPrimaryWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                            color: ColorConstants.launchpadPrimaryBlack
                                .withOpacity(
                              0.3,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/exerciseCountVector.png',
                                  height: 25,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Text(
                                    "12 exe",
                                    style: TextStyle(
                                      fontSize: 26,
                                      color:
                                          ColorConstants.launchpadPrimaryWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),

          // ************
          // Intensity Graph
          // ************

          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Intensity",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.launchpadPrimaryWhite,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 10, bottom: 15, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorConstants.launchpadPrimaryBlack.withOpacity(
                      0.3,
                    ),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: IntensityGraph(
                    [
                      1,
                      2,
                      3,
                      4,
                      5,
                      3,
                      4,
                      2,
                      4,
                      5,
                      4,
                      3,
                      2,
                      3,
                      4,
                      1,
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ************
          // Start Workout Button
          // ************
          Container(
            height: 75,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 30),
            child: RaisedButton.icon(
              color: ColorConstants.launchpadPlayButtonBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(110),
              ),
              onPressed: () {
                print("worked");
              },
              icon: Icon(
                Icons.play_arrow,
                color: ColorConstants.launchpadPrimaryWhite,
                size: 45,
              ),
              label: Text(
                "Start Workout",
                style: TextStyle(
                  color: ColorConstants.launchpadPrimaryWhite,
                  fontSize: 28,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
