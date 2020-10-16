import 'package:flutter/material.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/exercise_model.dart';
import 'package:tabletapp/models/workout_details.dart';

import 'exercise_preview_card.dart';

class WorkoutDetailsScrollView extends StatelessWidget {
  final List<ExerciseModel> distinctExerciseList;

  WorkoutDetailsScrollView(this.distinctExerciseList);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 3.5,
      ),
      height: SizeConfig.blockSizeVertical * 19.25,
      child: ListView.separated(
        key: ObjectKey(distinctExerciseList[0]),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 2,
        ),
        itemCount: distinctExerciseList.length,
        itemBuilder: (BuildContext context, int index) =>
            ExercisePreviewCard(distinctExerciseList[index].name),
        separatorBuilder: (BuildContext context, int index) => Divider(
          indent: 0,
          endIndent: SizeConfig.blockSizeHorizontal * 2,
        ),
      ),
    );
  }
}
