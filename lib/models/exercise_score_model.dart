import 'package:flutter/material.dart';

import 'exercise_set_model.dart';

class ExerciseScoreModel extends ChangeNotifier {
  ExerciseSetModel exerciseSetDefinition;
  int goodReps;
  int badReps;
  double value;

  ExerciseScoreModel(
      {this.exerciseSetDefinition, this.value, this.goodReps, this.badReps});

  int get totalReps => goodReps + badReps;
  int get getValue => goodReps + badReps;
}
