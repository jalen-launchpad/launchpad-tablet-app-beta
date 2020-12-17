import 'package:json_annotation/json_annotation.dart';

import 'workout_details.dart';
import 'workout_set_model.dart';

part 'workout_metadata.g.dart';

@JsonSerializable()
class WorkoutMetadata {
  // Sorted by earliest appearance to latest appearance in video.
  final List<WorkoutSetModel> workoutSets;
  final WorkoutDetails workoutDetails;
  final String streamUri;

  WorkoutMetadata(this.workoutSets, this.workoutDetails, this.streamUri);
  factory WorkoutMetadata.fromJson(Map<String, dynamic> json) =>
      _$WorkoutMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutMetadataToJson(this);
}
