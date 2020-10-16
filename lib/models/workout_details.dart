import 'package:json_annotation/json_annotation.dart';
import 'package:tabletapp/enums/mods_enum.dart';

import 'exercise_model.dart';

part 'workout_details.g.dart';

// WorkoutDetails is a model that encapsulates all the relevant
// information that a Workout requires to display on HomePage.

@JsonSerializable()
class WorkoutDetails {
  final String title;
  final String trainer;
  final String athlete;
  final List<ModsEnum> modsList;
  final List<ExerciseModel> exerciseList;
  final List<int> exerciseIntensities;
  final double duration;
  final String workoutId;

  WorkoutDetails(this.exerciseList,
      {this.title,
      this.trainer,
      this.athlete,
      this.modsList,
      this.workoutId,
      this.duration})
      : this.exerciseIntensities = createExerciseIntensitiesList(exerciseList);

  factory WorkoutDetails.fromJson(Map<String, dynamic> json) => _$WorkoutDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutDetailsToJson(this);

  static List<int> createExerciseIntensitiesList(
      List<ExerciseModel> exercises) {
    List<int> list = [];
    exercises.forEach((element) {
      list.add(element.intensity);
    });
    return list;
  }

  int get exerciseCount => exerciseList.length;
}
