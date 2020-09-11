import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';

class ExerciseRotatingList extends StatefulWidget {
  final List<String> exerciseList = [
    "Box Jumps",
    "Deadlifts",
    "Squats",
    "Band Pulls",
    "Palloff Press",
    "Depth Drops",
    "Depth Jumps",
    "Spider Pushups"
  ];
  @override
  _ExerciseRotatingListState createState() =>
      _ExerciseRotatingListState(exerciseList: exerciseList);
}

class _ExerciseRotatingListState extends State<ExerciseRotatingList> {
  int exerciseListIndex = 3;
  final exerciseList;
  int exerciseListLength;
  _ExerciseRotatingListState({this.exerciseList}) {
    exerciseListLength = exerciseList.length;
    Timer.periodic(Duration(seconds: 3), (callback) {
      setState(() {
        exerciseListIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 150,
        width: 250,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Image.asset('assets/exercise_rotating_list_bar.png')),
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                exerciseListIndex + 3 < exerciseListLength
                    ? exerciseList[exerciseListIndex + 3]
                    : '',
                style: TextStyle(
                  fontSize: 24,
                  color: ColorConstants.launchpadPrimaryBlue,
                ),
              ),
              Text(
                  exerciseListIndex + 2 < exerciseListLength
                      ? exerciseList[exerciseListIndex + 2]
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConstants.launchpadPrimaryBlue,
                  )),
              Text(
                  exerciseListIndex + 1 < exerciseListLength
                      ? exerciseList[exerciseListIndex + 1]
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConstants.launchpadPrimaryBlue,
                  )),

              // CURRENT EXERCISE
              Text(exerciseList[exerciseListIndex],
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConstants.launchpadPrimaryBlue,
                  )),
              // PAST EXERCISES
              Text(
                  exerciseListIndex - 1 >= 0
                      ? exerciseList[exerciseListIndex - 1]
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    color:
                        ColorConstants.launchpadPrimaryBlue.withOpacity(0.75),
                  )),
              Text(
                  exerciseListIndex - 2 >= 0
                      ? exerciseList[exerciseListIndex - 2]
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConstants.launchpadPrimaryBlue.withOpacity(0.5),
                  )),
              Text(
                  exerciseListIndex - 3 >= 0
                      ? exerciseList[exerciseListIndex - 3]
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    color:
                        ColorConstants.launchpadPrimaryBlue.withOpacity(0.25),
                  )),
            ])
          ],
        ));
  }
}
