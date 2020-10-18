
import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@JsonSerializable(nullable: false)
class ExerciseModel {
  final String exerciseName;
  final int intensity;
  

  ExerciseModel({this.exerciseName, this.intensity});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => _$ExerciseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

}