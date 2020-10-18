import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'exercise_set_model.dart';

part 'exercise_score_model.g.dart';


@JsonSerializable()
class ExerciseScoreModel extends ChangeNotifier {
  ExerciseSetModel exerciseSetDefinition;
  int goodReps;
  int badReps;
  int value;

  ExerciseScoreModel(
      {this.exerciseSetDefinition, this.value, this.goodReps, this.badReps});

  int get totalReps => goodReps + badReps;

  // Replace with real information from a scoring heuristic.
  int get getValue => goodReps + badReps;
}
