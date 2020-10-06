import 'package:flutter/material.dart';

class IntensityGraph extends StatelessWidget {
  final intToIntensityMap = {
    1: Container(
        height: 20,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(100),
        )),
    2: Container(
        height: 30,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(100),
        )),
    3: Container(
        height: 40,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(100),
        )),
    4: Container(
        height: 50,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(100),
        )),
    5: Container(
        height: 60,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(100),
        )),
  };
  final List<int> intensities;

  IntensityGraph(this.intensities);

  List<Widget> convertInputToExpandedIntensities() {
    List<Widget> list = [];
    list.add(Padding(padding: EdgeInsets.only(left: 10)));
    for (int x = 0; x < intensities.length; x++) {
      list.add(Flexible(child: intToIntensityMap[intensities[x]]));
      list.add(
        Spacer(
          flex: 1
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: convertInputToExpandedIntensities(),
      ),
    );
  }
}
