import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';

import 'rep_counter.dart';

class Metrics extends StatefulWidget {
  @override
  _MetricsState createState() => _MetricsState();
}

class _MetricsState extends State<Metrics> {
  final controller = StreamController<int>();
  int repCount = 0;
  _MetricsBarState() {
    // TODO: Replace this hardcoded timer with real values
    var duration = Duration(seconds: 2);
    Timer.periodic(duration, (timer) {
      repCount += 1;
      controller.add(repCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  height: 150,
                  child: Container(),
                  color: ColorConstants.launchpadPrimaryBlue),
            ),
            Expanded(
              child: Container(
                color: ColorConstants.launchpadPrimaryDarkGrey,
                height: 150,
                child: Container(),
              ),
            ),
            Expanded(
                child: Container(
              height: 150,
              color: ColorConstants.launchpadPrimaryBlack,
              child: Container(),
            )),
          ],
        ));
  }
}
