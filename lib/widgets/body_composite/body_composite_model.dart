import 'package:flutter/material.dart';

class BodyCompositeModel {
  List<MuscleFatiguePoint> muscleFatiguePoints;
}

class MuscleFatiguePoint {
  BodyPartEnum bodyPart;
  FatigueLevelEnum fatigueLevel;

  MuscleFatiguePoint({this.bodyPart, this.fatigueLevel});
}

enum BodyPartEnum {
  rightArm,
  leftArm,
  rightShoulder,
  leftShoulder,
  rightLeg,
  leftLeg,
  core,
}

enum FatigueLevelEnum {
  notFatigued,
  slightlyFatigued,
  veryFatigued,
  extremelyFatigued,
}

class Coordinates {
  double top;
  double left;
  Coordinates({this.top, this.left});
}

final bodyCompositeCoordinateMap = {
  BodyPartEnum.leftArm: Coordinates(top: 270, left: 70),
  BodyPartEnum.rightArm: Coordinates(top: 270, left: 200),
  BodyPartEnum.core: Coordinates(top: 290, left: 136),
  BodyPartEnum.leftLeg: Coordinates(top: 510, left: 108),
  BodyPartEnum.rightLeg: Coordinates(top: 510, left: 166),
  BodyPartEnum.leftShoulder: Coordinates(top: 170, left: 93),
  BodyPartEnum.rightShoulder: Coordinates(top: 170, left: 180),
};

final fatigueLevelToColorMap = {
  FatigueLevelEnum.notFatigued: Colors.lightGreen,
  FatigueLevelEnum.slightlyFatigued: Colors.yellow[300],
  FatigueLevelEnum.veryFatigued: Colors.orange[300],
  FatigueLevelEnum.extremelyFatigued: Colors.red,
};
