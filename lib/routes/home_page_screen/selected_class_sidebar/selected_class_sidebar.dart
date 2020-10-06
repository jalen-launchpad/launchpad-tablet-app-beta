import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/routes/home_page_screen/selected_class_sidebar/exercise_preview_card.dart';

import 'intensity_graph.dart';

class SelectedClassSidebar extends StatefulWidget {
  @override
  _SelectedClassSidebarState createState() => _SelectedClassSidebarState();
}

class _SelectedClassSidebarState extends State<SelectedClassSidebar> {
  static const String title = "Shoulder Blast";
  static const double time = 50;
  static const double exerciseCount = 12;
  static const intensities = [
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
  ];

  static double horizontalOutsidePadding =
      SizeConfig.blockSizeHorizontal * 2.75;
  static const double workoutInformationBucketHeight = 80;
  static double timeExerciseBucketWidth = SizeConfig.blockSizeHorizontal * 12.8;
  static const double timeExerciseIconTextSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.launchpadPrimaryBlue,
      padding: EdgeInsets.only(
        left: horizontalOutsidePadding,
      ),
      child: Column(
        children: [
          // ************
          // Calendar, Today's Workout Text and Settings Logo
          // ************
          Container(
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 4,
            ),
            child: Row(
              children: [
                Container(
                  child: Image.asset('assets/images/calendarVector.png',
                      height: SizeConfig.blockSizeVertical * 3.5),
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
                  padding: EdgeInsets.only(
                      left: 1.5 * SizeConfig.blockSizeHorizontal),
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
                // TODO(jalen): REAL VALUE NEEDED
                Text(title,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 35,
                      color: ColorConstants.launchpadPrimaryWhite,
                    )),
              ],
            ),
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2.25,
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
              top: SizeConfig.blockSizeVertical * 2.25,
            ),
          ),
          // ************
          // Workout Details Scrollview
          // ************
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 3.5,
            ),
            height: SizeConfig.blockSizeVertical * 19.25,
            // TODO(jalen): REAL VALUE NEEDED
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 2,
              ),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) =>
                  ExercisePreviewCard(),
              separatorBuilder: (BuildContext context, int index) => Divider(
                indent: 0,
                endIndent: SizeConfig.blockSizeHorizontal * 2,
              ),
            ),
          ),

          // ************
          // Exercise and Time Buckets
          // ************
          Container(
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 3.5,
            ),
            child: Row(
              children: [
                // ************
                // Time Bucket
                // ************
                Container(
                  padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2.5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical,
                        ),
                        width: timeExerciseBucketWidth,
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
                          height: workoutInformationBucketHeight,
                          width: timeExerciseBucketWidth,
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
                                  height: SizeConfig.blockSizeVertical * 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: timeExerciseIconTextSpacing,
                                  ),
                                  child: Text(
                                    // TODO(jalen): REAL VALUE NEEDED

                                    time.toInt().toString() + " min",
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
                // Exercise Bucket
                // ************
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical,
                        ),
                        width: timeExerciseBucketWidth,
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
                          height: workoutInformationBucketHeight,
                          width: timeExerciseBucketWidth,
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
                                  // TODO(jalen): REAL VALUE NEEDED
                                  'assets/images/exerciseCountVector.png',
                                  height: SizeConfig.blockSizeVertical * 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: timeExerciseIconTextSpacing,
                                  ),
                                  child: Text(
                                    // TODO(jalen): REAL VALUE NEEDED
                                    exerciseCount.toInt().toString() + " exe",
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
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
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
                  height: workoutInformationBucketHeight,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical,
                    bottom: SizeConfig.blockSizeVertical * 4,
                    right: horizontalOutsidePadding,
                  ),
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
                    // TODO(jalen): REAL VALUE NEEDED
                    intensities,
                  ),
                ),
              ],
            ),
          ),
          // ************
          // Start Workout Button
          // ************
          Container(
            height: SizeConfig.blockSizeVertical * 10,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: horizontalOutsidePadding),
            child: RaisedButton.icon(
              color: ColorConstants.launchpadPlayButtonBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(110),
              ),
              onPressed: () {
                // TODO(jalen): REAL VALUE NEEDED
                print("worked");
              },
              icon: Icon(
                Icons.play_arrow,
                color: ColorConstants.launchpadPrimaryWhite,
                size: SizeConfig.blockSizeHorizontal * 5,
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
