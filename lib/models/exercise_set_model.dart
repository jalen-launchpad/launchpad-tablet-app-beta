import 'package:json_annotation/json_annotation.dart';

part 'exercise_set_model.g.dart';

@JsonSerializable()
class ExerciseSetModel {
  final String exerciseName;
  final int targetReps;
  final bool perSide;
  final bool isTime;
  final double scoreMultiplier;
  final int maxScore;
  final String scoreTag;

  ExerciseSetModel({
    this.exerciseName,
    this.targetReps,
    this.perSide = false,
    this.isTime = false,
    this.scoreMultiplier = 1.0,
    this.maxScore,
    this.scoreTag,
  });
  factory ExerciseSetModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetModelToJson(this);
}
