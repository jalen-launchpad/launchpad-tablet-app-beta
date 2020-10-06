import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';

class ExercisePreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.launchpadPrimaryWhite,
      ),
      child: Container(
          width: 120,
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
                    "Shoulder Press",
                    style: TextStyle(
                      color: ColorConstants.launchpadPrimaryWhite,
                      fontSize: 16,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
