import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'exercise_model.g.dart';

@JsonSerializable(nullable: false)
class ExerciseModel {
  final String exerciseName;
  final int intensity;

  ExerciseModel({@required this.exerciseName, @required this.intensity});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);
}
