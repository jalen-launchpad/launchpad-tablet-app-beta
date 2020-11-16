import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';

import '../constants.dart';

class IntensityGraph extends StatelessWidget {
  static double width = SizeConfig.blockSizeHorizontal;
  static double height = SizeConfig.blockSizeVertical;
  static double borderRadius = 100;
  static double horizontalOutsidePadding =
      SizeConfig.blockSizeHorizontal * 2.75;

  final intToIntensityMap = {
    1: Container(
        height: height * 4,
        width: width * 5,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(borderRadius),
        )),
    2: Container(
        height: height * 5,
        width: width * 5,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(borderRadius),
        )),
    3: Container(
        height: height * 6,
        width: width * 5,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(borderRadius),
        )),
    4: Container(
        height: height * 7,
        width: width * 5,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(borderRadius),
        )),
    5: Container(
        height: height * 8,
        width: width * 5,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(borderRadius),
        )),
  };

  final List<int> intensities;
  IntensityGraph(this.intensities);

  List<Widget> convertInputToExpandedIntensities() {
    List<Widget> list = [];
    list.add(Spacer(flex: 1));
    for (int x = 0; x < intensities.length; x++) {
      list.add(Flexible(child: intToIntensityMap[intensities[x]]));
      list.add(
        Spacer(flex: 1),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Intensity",
                style: TextStyle(
                  fontSize: SelectedClassSidebarConstants.subTextSize,
                  color: ColorConstants.launchpadPrimaryWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            height:
                SelectedClassSidebarConstants.workoutInformationBucketHeight,
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
                SelectedClassSidebarConstants.bucketBorderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: convertInputToExpandedIntensities(),
            ),
          ),
        ],
      ),
    );
  }
}
