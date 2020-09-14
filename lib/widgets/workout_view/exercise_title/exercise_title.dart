import 'package:flutter/material.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ExerciseTitle extends StatefulWidget {
  @override
  _ExerciseTitleState createState() => _ExerciseTitleState();
}

class _ExerciseTitleState extends State<ExerciseTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<WorkoutVideoScreenState, String>(
      converter: (store) =>
          store.state.currentExercise.exerciseSetDefinition.exerciseName,
      builder: (context, exerciseTitle) {
        return Text(exerciseTitle);
      },
    ));
  }
}
