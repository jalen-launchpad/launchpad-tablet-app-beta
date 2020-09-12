import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';

class ExerciseTitle extends StatefulWidget {
  @override
  _ExerciseTitleState createState() => _ExerciseTitleState();
}

class _ExerciseTitleState extends State<ExerciseTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<LeaderboardEntryModel>(
      builder: (context, leaderboardEntryModel, child) {
        return Container(height: 100, child: Text(leaderboardEntryModel.exerciseSetDefinition.exerciseName));
      },
    ));
  }
}
