import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

class ExercisePreviewCard extends StatelessWidget {
  final String exerciseName;
  ExercisePreviewCard(this.exerciseName);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.launchpadPrimaryWhite,
      ),
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.launchpadMenuExerciseBlue.withOpacity(0.8),
          ),
          child: Stack(
            children: [
              // Todo(jalen): add image of exercise
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    exerciseName,
                    style: TextStyle(
                        color: ColorConstants.launchpadPrimaryWhite,
                        fontSize: SizeConfig.blockSizeHorizontal * 1.2,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal,
                    right: SizeConfig.blockSizeHorizontal,
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
