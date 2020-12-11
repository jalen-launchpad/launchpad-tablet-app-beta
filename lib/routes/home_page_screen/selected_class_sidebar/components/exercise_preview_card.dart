import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

class ExercisePreviewCard extends StatelessWidget {
  final String exerciseName;
  final AssetImage image;
  final int number;
  ExercisePreviewCard(this.exerciseName, this.image, this.number);
  static double height = SizeConfig.blockSizeVertical * 19.25;
  static double width = SizeConfig.blockSizeHorizontal * 12;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.launchpadPrimaryWhite,
        image: DecorationImage(
          image: this.number == 1
              ? AssetImage('assets/images/exerciseCard1.jpg')
              : this.number == 2
                  ? AssetImage('assets/images/exerciseCard2.jpg')
                  : this.number == 3
                      ? AssetImage('assets/images/exerciseCard3.jpg')
                      : this.number == 4
                          ? AssetImage('assets/images/exerciseCard4.jpg')
                          : AssetImage('assets/images/exerciseCard5.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      height: height,
      width: width,
      child: Container(
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
