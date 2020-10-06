import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_actions.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_reducers.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';

import 'workout_notification.dart';

class WorkoutNotificationBar extends StatelessWidget {
  final WorkoutNotification workoutNotification;
  final Store<WorkoutVideoScreenState> store;
  WorkoutNotificationBar(this.workoutNotification, this.store) {
    Timer(Duration(seconds: 5),
        () => store.dispatch(ClearNotificationBarAction()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 450,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            this.workoutNotification.notification,
            style: TextStyle(
                fontSize: 100, color: ColorConstants.launchpadPrimaryWhite),
          )),
      decoration: BoxDecoration(
        color: workoutNotification.notificationColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(60),
      ),
    );
  }
}
