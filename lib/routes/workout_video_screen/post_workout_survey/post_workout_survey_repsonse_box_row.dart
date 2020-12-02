import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:redux/redux.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_actions.dart';

import '../workout_video_screen_state.dart';

class PostWorkoutSurveyResponseBoxRow extends StatefulWidget {
  final Store<WorkoutVideoScreenState> store;
  final String field;
  PostWorkoutSurveyResponseBoxRow(this.store, this.field);
  @override
  _PostWorkoutSurveyResponseBoxRowState createState() =>
      _PostWorkoutSurveyResponseBoxRowState(this.store, this.field);
}

class _PostWorkoutSurveyResponseBoxRowState
    extends State<PostWorkoutSurveyResponseBoxRow> {
  List<bool> iconSelected = [true, true, true, true, true];
  final String field;

  _PostWorkoutSurveyResponseBoxRowState(this.store, this.field);

  final Store<WorkoutVideoScreenState> store;

  int getValue() {
    if (iconSelected[4]) return 5;
    if (iconSelected[3]) return 4;
    if (iconSelected[2]) return 3;
    if (iconSelected[1]) return 2;
    return 1;
  }

  void _iconSelected(int location) {
    setState(() {
      // Reset all icons to false.
      for (int x = 0; x < iconSelected.length; x++) {
        iconSelected[x] = false;
      }
      // For all the icons lower or equal to current selection, set to true.
      for (; location >= 0; location--) {
        iconSelected[location] = true;
      }

      store.dispatch(UpdatePostWorkoutSurveyInputAction(
          field: this.field, value: getValue()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: SizeConfig.blockSizeHorizontal * 10,
          child: Text(this.field,
              style: TextStyle(
                color: ColorConstants.launchpadPrimaryWhite,
                fontSize: SizeConfig.blockSizeHorizontal * 2,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
            width: SizeConfig.blockSizeHorizontal * 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: iconSelected[0] ? Colors.yellow[600] : Colors.grey,
                  ),
                  onPressed: () {
                    _iconSelected(0);
                  },
                  iconSize: SizeConfig.blockSizeHorizontal * 3,
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: iconSelected[1] ? Colors.yellow[600] : Colors.grey,
                  ),
                  onPressed: () {
                    _iconSelected(1);
                  },
                  iconSize: SizeConfig.blockSizeHorizontal * 3,
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: iconSelected[2] ? Colors.yellow[600] : Colors.grey,
                  ),
                  onPressed: () {
                    _iconSelected(2);
                  },
                  iconSize: SizeConfig.blockSizeHorizontal * 3,
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: iconSelected[3] ? Colors.yellow[600] : Colors.grey,
                  ),
                  onPressed: () {
                    _iconSelected(3);
                  },
                  iconSize: SizeConfig.blockSizeHorizontal * 3,
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: iconSelected[4] ? Colors.yellow[600] : Colors.grey,
                  ),
                  onPressed: () {
                    _iconSelected(4);
                  },
                  iconSize: SizeConfig.blockSizeHorizontal * 3,
                ),
              ],
            )),
      ],
    );
  }
}
