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
      {this.exerciseSetDefinition,
      this.value = 0,
      this.goodReps = 0,
      this.badReps = 0});

  int get totalReps => goodReps + badReps;

  // Replace with real information from a scoring heuristic.
  int get getValue => value;

  factory ExerciseScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseScoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseScoreModelToJson(this);
}
