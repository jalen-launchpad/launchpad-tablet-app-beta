// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) {
  return ExerciseModel(
    exerciseName: json['exerciseName'] as String,
    intensity: json['intensity'] as int,
  );
}

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'exerciseName': instance.exerciseName,
      'intensity': instance.intensity,
    };
