
import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@JsonSerializable(nullable: false)
class ExerciseModel {
  final String name;
  final int intensity;

  ExerciseModel({this.name, this.intensity});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => _$ExerciseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

}