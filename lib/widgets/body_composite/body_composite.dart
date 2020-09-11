import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/widgets/body_composite/body_composite_model.dart';

class BodyComposite extends StatefulWidget {
  final BodyCompositeModel bodyCompositeModel;

  BodyComposite({this.bodyCompositeModel});

  @override
  State<StatefulWidget> createState() =>
      _BodyCompositeState(bodyCompositeModel: this.bodyCompositeModel);
}

class _BodyCompositeState extends State<BodyComposite> {
  final BodyCompositeModel bodyCompositeModel;
  List<BodyCompositePoint> allBodyCompositePoints = [];

  _BodyCompositeState({this.bodyCompositeModel}) {
    this.bodyCompositeModel.muscleFatiguePoints.forEach((element) {
      allBodyCompositePoints
          .add(BodyCompositePoint(muscleFatiguePoint: element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/bodycomp.png'),
      )),
      child: Stack(
        children: allBodyCompositePoints,
      ),
    );
  }
}

class BodyCompositePoint extends StatelessWidget {
  final MuscleFatiguePoint muscleFatiguePoint;

  BodyCompositePoint({this.muscleFatiguePoint});

  @override
  Widget build(BuildContext context) {
    var coords = bodyCompositeCoordinateMap[muscleFatiguePoint.bodyPart];
    return Container(
        child: Stack(children: [
      Positioned(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fatigueLevelToColorMap[muscleFatiguePoint.fatigueLevel],
                border: Border.all(color: ColorConstants.launchpadPrimaryBlue, width: 3)),
          ),
          top: coords.top,
          left: coords.left),
    ]));
  }
}
