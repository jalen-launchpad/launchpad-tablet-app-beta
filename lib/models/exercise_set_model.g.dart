// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSetModel _$ExerciseSetModelFromJson(Map<String, dynamic> json) {
  return ExerciseSetModel(
    exerciseName: json['exerciseName'] as String,
    targetReps: json['targetReps'] as int,
    perSide: json['perSide'] as bool,
    isTime: json['isTime'] as bool,
  );
}

Map<String, dynamic> _$ExerciseSetModelToJson(ExerciseSetModel instance) =>
    <String, dynamic>{
      'exerciseName': instance.exerciseName,
      'targetReps': instance.targetReps,
      'perSide': instance.perSide,
      'isTime': instance.isTime,
    };
