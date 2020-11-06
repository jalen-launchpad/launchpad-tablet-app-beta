import 'package:json_annotation/json_annotation.dart';
import 'package:tabletapp/models/exercise_set_model.dart';

part 'workout_set_model.g.dart';

@JsonSerializable()
class WorkoutSetModel {
  final ExerciseSetModel exerciseSetDefinition;

  // Is this a rest period?
  final bool isRest;

  // Timestamp of the beginning of the set in
  // seconds since start of video.
  final int videoTimestamp;

  // Length the set takes to complete in the video.
  final int videoEndTimestamp;

  factory WorkoutSetModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutSetModelToJson(this);

  WorkoutSetModel({
    this.exerciseSetDefinition,
    this.videoTimestamp,
    this.isRest,
    this.videoEndTimestamp,
  });
}
